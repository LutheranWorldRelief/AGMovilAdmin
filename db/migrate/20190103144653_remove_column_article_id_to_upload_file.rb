class RemoveColumnArticleIdToUploadFile < ActiveRecord::Migration[5.2]
  def change
  	remove_column :upload_files, :article_id
  end
end
