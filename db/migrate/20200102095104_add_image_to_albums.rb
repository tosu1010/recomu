class AddImageToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :image, :string
  end
end
