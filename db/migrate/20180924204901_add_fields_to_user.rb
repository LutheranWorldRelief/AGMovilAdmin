class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :names, :string
    add_column :users, :lastnames, :string
  end
end
