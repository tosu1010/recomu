class Album < ApplicationRecord
  belongs_to :artist

  def self.create_album(artist_id, title)
    album = Album.create(title: title, artist_id: artist_id)
  end
end
