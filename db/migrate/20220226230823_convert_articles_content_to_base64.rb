class ConvertArticlesContentToBase64 < ActiveRecord::Migration[5.2]
  def up
    puts "RUNNING MIGRATION TO GENERATE BASE64 CONTENT"
    articles = Article.all
    i = 0
    count=articles.count

    puts "number of articles #{count}"

    articles.each do |article|
      i=i+1
      puts "#{i}/#{count} :: #{article.slug}"
      article.update(content_base_64: '')
    end
  end

  def down

    execute <<-SQL
      UPDATE articles SET content_base_64 = null;
    SQL

  end
end
