module SpotifyMethod
  extend ActiveSupport::Concern

  # 認証
  def spotify_auth
    client_id = Rails.application.credentials.spotify[:client_id]
    client_secret = Rails.application.credentials.spotify[:client_secret]
    # spotifyの認証を通っていなかった場合は、sessionに保存する
    session[:spotify_auth] = RSpotify.authenticate(client_id , client_secret) unless session[:spotify_auth]
  end

  # artistのspotify_idを取得する
  def get_artist_spotify(artist_name)
    artist = RSpotify::Artist.search(artist_name).first
  end

  # 引数に渡したalbumのspotify_idを取得する
  def get_album_spotify(artist_spotify_id, album_name)
    artist = RSpotify::Artist.find(artist_spotify_id)
    album = artist.albums(album_type: 'single', limit: 50).find { |album| album.name.include?(album_name) }
    unless album
      album = artist.albums(album_type: 'album', limit: 50).find { |album| album.name.include?(album_name) }
      unless album
        album = artist.albums(album_type: 'compilation', limit: 50).find { |album| album.name.include?(album_name) }
        unless album
          album_name = "*#{album_name.gsub(/\s/, '%20')}*"
          album = RSpotify::Album.search(album_name).map { |album| 
                    album.artists.find { |artist| 
                      artist.id == artist_spotify_id }
                    }[0]
        end
      end
    end
    album ? album : nil
  end

  # アルバムの画像を探す
  def get_album_image(album_spotify_id)
    image = RSpotify::Album.find(album_spotify_id)
    image ? image.images[0]['url'] : 'no_image.png'
  end

  # トラックの取得
  def get_tracks(album_spotify_id)
    RSpotify::Album.find(album_spotify_id).tracks
  end



end