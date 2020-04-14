# CACAO MOVIL ADMINISTRATOR

# HOW TO INSTALL

### Technologies
  >
    1. Ruby: 2.5.3
    2. Rails: 5.2
    3. Postgresql: 9.3

### First install Postgresql

  > sudo yum install postgresql-server postgresql-contrib
 
### Configure Postgresql
  1. sudo -i -u postgres
  2. sudo -u postgres psql
  3. ALTER USER postgres WITH PASSWORD 'YOUR PASSWORD';
  
  4. Edit pg_hba.conf in /etc/postgresql/**YOU PSQL VERSION**/main/pg_hba.conf and change 
    
    *BEFORE*
    
    > host     all        postgres           your.ip your.subnet      peer
    
    *AFTER*
    
    > host     all        postgres           your.ip your.subnet      md5 
  
  5. Test your connection
    
    > psql -U postgres -W

### Install RVM
  >
    1. gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    2. curl -sSL https://get.rvm.io | bash -s stable

### get the packages required by ruby
  >
    rvm pkg install zlib
    rvm pkg install openssl

### Then, install Ruby 2.5.3
  >
    rvm install 2.5.3

### Install passenger (First install EPEL)
  >
    sudo yum install -y epel-release yum-utils

    sudo yum-config-manager --enable epel

    sudo yum clean all && sudo yum update -y

### Install passenger (Repair potential system issues) optional
  >
    sudo yum update -y

    sudo yum install -y ntp

    sudo chkconfig ntpd on

    sudo ntpdate pool.ntp.org
    
    sudo service ntpd start

### Install Passenger (install packages)
  >
    sudo yum install -y pygpgme curl
    
    sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

    sudo yum install -y nginx passenger || sudo yum-config-manager --enable cr && sudo yum install -y nginx passenger

### Edit /etc/nginx/conf.d/passenger.conf and uncomment passenger_root, passenger_ruby and passenger_instance_registry_dir
  > 
    # passenger_root /some-filename/locations.ini; (remove #)
    # passenger_ruby /usr/bin/ruby; (remove #)
    # passenger_instance_registry_dir /var/run/passenger-instreg; (remove #)

### Restart NGINX Service 
  >
    sudo service nginx restart
  
### Clone the project in /var/www/html or your prefered route
  > 
    git clone **COCOA REPO**

### IMPORTANT! EVER EXPORT YOUR ENVIROMENT WHEN YOUR CONNECT WITH THE SERVER BY SSH
  > 
    export RAILS_ENV=production

### Install gems
  >
    1. cd **PROJECT_PATH**
    2. bundle install

### Generate secret token for requests and paste it, in production key inside config/secrets.yml file
  >
    bundle exec rake secrets

## Modify your connection database settings in config/database.yml and put your postgresql's (user, password and database name) credentials in production key

### Create database and run migrations
  >
    1. bundle exec rake db:create
    2. bundle exec rake db:migrate

### Run database seed for create user administrator
  >
    1. open with vim or nano db/seeds.rb and change it with your prefer credentials
    2. bundle exec rake db:seed

### Precompile assets, this command precompile all images, javascripts and css
  >
    1. bundle exec rake assets:precompile
    
### Restart the services
  >
    1. touch tmp/restart.txt
    2. /etc/init.d/apache2 restart
