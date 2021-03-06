module SpotifyMethod
  extend ActiveSupport::Concern
  
  # artistのspotify情報取得する
  def get_artist_spotify(artist_name)
    artist_name.present? ? RSpotify::Artist.search(artist_name).first : nil
  end

  # 引数に渡したalbumのspotify情報を取得する
  def get_album_spotify(artist_spotify_id, album_name)
    artist = RSpotify::Artist.find(artist_spotify_id)
    album = artist.albums(album_type: 'single', limit: 50).find { |album| album.name.include?(album_name) }
    unless album
      album = artist.albums(album_type: 'album', limit: 50).find { |album| album.name.include?(album_name) }
      unless album
        album = artist.albums(album_type: 'compilation', limit: 50).find { |album| album.name.include?(album_name) }
        unless album
          album_name = "*#{album_name.gsub(/\s/, '%20')}*"
          album = RSpotify::Album.search(album_name).map { |search_album| 
                    search_album.artists.find { |search_artist| 
                      search_artist.id == artist_spotify_id }
                    }[0]
        end
      end
    end
    album ? album : nil
  end

  # アルバムの画像を探す
  def get_album_image(album_spotify_id)
    image = RSpotify::Album.find(album_spotify_id)
    image.images[0]['url']
  end

  # トラックの取得
  def get_tracks(album_spotify_id)
    RSpotify::Album.find(album_spotify_id).tracks
  end
end