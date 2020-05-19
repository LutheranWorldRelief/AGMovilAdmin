class AddImageToCategoryApp < ActiveRecord::Migration[5.2]
  def change
    add_column :category_apps, :icon, :string
  end
end
