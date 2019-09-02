class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :name
      t.string :image
      t.integer :app_type
      t.text :app_url

      t.timestamps
    end
  end
end
