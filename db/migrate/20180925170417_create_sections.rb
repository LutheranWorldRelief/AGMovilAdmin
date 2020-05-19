class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :order, default: 0
      t.references :guide, foreign_key: true

      t.timestamps
    end
  end
end
