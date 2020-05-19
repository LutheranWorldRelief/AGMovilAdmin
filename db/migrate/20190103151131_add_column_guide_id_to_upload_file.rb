class AddColumnGuideIdToUploadFile < ActiveRecord::Migration[5.2]
  def change
    add_reference :upload_files, :guide, foreign_key: true
  end
end
