class Album < ApplicationRecord
  belongs_to :artist

  def self.find_album(title, artist_id)
    album = Album.find_by(title: title, artist_id: artist_id)
    unless album.present?
      album = Album.create!(title: title, artist_id: artist_id)
    end
    album
  end
end
