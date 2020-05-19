class AddSlugToGuide < ActiveRecord::Migration[5.2]
  def change
    add_column :guides, :slug, :string
  end
end
