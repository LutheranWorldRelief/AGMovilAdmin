class CreateGuides < ActiveRecord::Migration[5.2]
  def change
    create_table :guides do |t|
      t.string :name
      t.integer :order, default: 0

      t.timestamps
    end
  end
end
