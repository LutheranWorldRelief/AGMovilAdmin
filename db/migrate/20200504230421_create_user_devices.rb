class CreateUserDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :user_devices do |t|
      t.text :token
      t.timestamps
    end
  end
end

