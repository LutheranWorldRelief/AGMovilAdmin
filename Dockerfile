FROM buildpack-deps:buster

# skip installing gem documentation
RUN set -eux; \
        mkdir -p /usr/local/etc; \
        { \
                echo 'install: --no-document'; \
                echo 'update: --no-document'; \
        } >> /usr/local/etc/gemrc

# https://www.ruby-lang.org/en/news/2018/03/28/ruby-2-5-1-released/
ENV RUBY_MAJOR 2.5
ENV RUBY_VERSION 2.5.1
ENV RUBY_DOWNLOAD_SHA256 886ac5eed41e3b5fc699be837b0087a6a5a3d10f464087560d2d21b3e71b754d
ENV RUBYGEMS_VERSION 3.0.3

# some of ruby's build scripts are written in ruby
#   we purge system ruby later to make sure our final image uses what we just built
RUN set -eux; \
        \
        savedAptMark="$(apt-mark showmanual)"; \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                bison \
                dpkg-dev \
                libgdbm-dev \
                ruby \
        ; \
        rm -rf /var/lib/apt/lists/*; \
        \
        wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz"; \
        echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum --check --strict; \
        \
        mkdir -p /usr/src/ruby; \
        tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1; \
        rm ruby.tar.xz; \
        \
        cd /usr/src/ruby; \
        \
# hack in "ENABLE_PATH_CHECK" disabling to suppress:
#   warning: Insecure world writable dir
        { \
                echo '#define ENABLE_PATH_CHECK 0'; \
                echo; \
                cat file.c; \
        } > file.c.new; \
        mv file.c.new file.c; \
        \
        autoconf; \
        gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
        ./configure \
                --build="$gnuArch" \
                --disable-install-doc \
                --enable-shared \
        ; \
        make -j "$(nproc)"; \
        make install; \
        \
        apt-mark auto '.*' > /dev/null; \
        apt-mark manual $savedAptMark > /dev/null; \
        find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec ldd '{}' ';' \
                | awk '/=>/ { print $(NF-1) }' \
                | sort -u \
                | xargs -r dpkg-query --search \
                | cut -d: -f1 \
                | sort -u \
                | xargs -r apt-mark manual \
        ; \
        apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
        \
        cd /; \
        rm -r /usr/src/ruby; \
# make sure bundled "rubygems" is older than RUBYGEMS_VERSION (https://github.com/docker-library/ruby/issues/246)
        ruby -e 'exit(Gem::Version.create(ENV["RUBYGEMS_VERSION"]) > Gem::Version.create(Gem::VERSION))'; \
        gem update --system "$RUBYGEMS_VERSION" && rm -r /root/.gem/; \
# verify we have no "ruby" packages installed
        ! dpkg -l | grep -i ruby; \
        [ "$(command -v ruby)" = '/usr/local/bin/ruby' ]; \
# rough smoke test
        ruby --version; \
        gem --version; \
        bundle --version

# don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1 \
        BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $GEM_HOME/bin:$PATH
# adjust permissions of a few directories for running "gem install" as an arbitrary user
RUN mkdir -p "$GEM_HOME" && chmod 777 "$GEM_HOME"

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs \
    yarn \
    wget \
    postgresql-client

RUN mkdir /app
RUN mkdir -p /unicorn/pids
RUN mkdir -p /unicorn/sockets
RUN mkdir -p /unicorn/log
RUN mkdir /tmp/rails-app

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]