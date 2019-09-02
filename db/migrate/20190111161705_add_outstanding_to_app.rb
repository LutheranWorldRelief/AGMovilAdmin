class AddOutstandingToApp < ActiveRecord::Migration[5.2]
  def change
    add_column :apps, :outstanding, :boolean, default: false
  end
end
