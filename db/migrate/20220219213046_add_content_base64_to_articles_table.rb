class AddContentBase64ToArticlesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :content_base_64, :text
  end
end
