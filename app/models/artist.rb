class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy

  def self.find_artist(name)
    artist = Artist.find_by(name: name)
    unless artist.present?
      artist = Artist.create!(name: name)
    end
    artist
  end
end
