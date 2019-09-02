class AddCategoryIdToGuide < ActiveRecord::Migration[5.2]
  def change
    add_reference :guides, :category, foreign_key: true
  end
end
