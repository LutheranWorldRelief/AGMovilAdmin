class AddOrderToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :cat_order, :integer
  end
end
