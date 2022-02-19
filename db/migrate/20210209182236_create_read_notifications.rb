class CreateReadNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :read_notifications do |t|
      t.text :user_key
      t.integer :notification_id
      t.timestamps
    end
  end
end
