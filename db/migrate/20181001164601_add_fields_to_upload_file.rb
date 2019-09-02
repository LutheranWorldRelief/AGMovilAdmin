class AddFieldsToUploadFile < ActiveRecord::Migration[5.2]
  def change
    add_column :upload_files, :description, :text
    add_column :upload_files, :name, :string
  end
end
