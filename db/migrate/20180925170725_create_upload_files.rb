class CreateUploadFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :upload_files do |t|
      t.string :file_upload
      t.integer :order, default: 0
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
