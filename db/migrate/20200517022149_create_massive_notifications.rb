class CreateMassiveNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :massive_notifications do |t|
      t.string :title
      t.text :message
      t.string :big_picture
      t.text :players, array: true, default: []
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
