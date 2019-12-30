class Album < ApplicationRecord
  belongs_to :artist
  has_many :reviews

  def self.find_album(title, artist_id)
    album = Album.find_by(title: title, artist_id: artist_id)
    unless album.present?
      album = Album.create!(title: title, artist_id: artist_id)
    end
    album
  end

  def another_albums()
    artist = self.artist
    artist.albums.where.not(id: self.id)
  end

end
