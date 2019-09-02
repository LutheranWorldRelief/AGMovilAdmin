class AddReferencesToApp < ActiveRecord::Migration[5.2]
  def change
    add_reference :apps, :category_app, foreign_key: true
  end
end
