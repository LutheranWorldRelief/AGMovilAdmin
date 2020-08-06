class CreateDeleteNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :delete_notifications do |t|
      t.text :user_key
      t.integer :notification_id
      t.timestamps
    end
  end
end
