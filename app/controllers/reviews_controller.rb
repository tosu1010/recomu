class ReviewsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def create
    artist_spotify_id = get_artist_spotify_id(review_params[:artist])
    if artist_spotify_id
      album_spotify_id = get_album_spotify_id(artist_spotify_id, review_params[:album])
      album_image = get_album_image(album_spotify_id)
    end

    Review.transaction do
      artist = Artist.find_or_create_by!(name: review_params[:artist], spotify_id: artist_spotify_id)
      album = Album.find_or_create_by!(title: review_params[:album], artist_id: artist.id, spotify_id: album_spotify_id, image: album_image)
      review = Review.create!(
        content: review_params[:review],
        user_id: current_user.id,
        album_id: album.id
      )
      review_params[:tags].each do |tag|
        tag_record = Tag.find_or_create_by!(name: tag)
        ReviewsTag.create!(review_id: review.id, tag_id: tag_record.id)
      end
    end
      flash[:success] = "登録しました！"
      redirect_to root_path
    rescue => e
      puts e
      flash[:failed] = e
      redirect_to new_review_path
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
  end

  private
  def review_params
    params.permit(:album, :artist, :review, tags: [])
  end

  def spotify_auth
    client_id = Rails.application.credentials.spotify[:client_id]
    client_secret = Rails.application.credentials.spotify[:client_secret]
    RSpotify.authenticate(client_id, client_secret)
  end

  # artistのspotify_idを取得する
  def get_artist_spotify_id(artist_name)
    spotify_auth

    artist = RSpotify::Artist.search(artist_name).first
    artist.present? ? artist.id : nil
  end

  # 引数に渡したalbumのspotify_idを取得する
  def get_album_spotify_id(artist_spotify_id, album_name)
    spotify_auth

    artist = RSpotify::Artist.find(artist_spotify_id)
    album = artist.albums(album_type: 'single', limit: 50).find { |album| album.name == album_name }
    unless album
      album = artist.albums(album_type: 'album', limit: 50).find { |album| album.name == album_name }
      unless album
        album = artist.albums(album_type: 'compilation', limit: 50).find { |album| album.name == album_name }
      end
    end
    album ? album.id : nil
  end

  # アルバムの画像を探す
  def get_album_image(album_spotify_id)
    spotify_auth

    image = RSpotify::Album.find(album_spotify_id)
    image ? image.images[0]['url'] : 'no_image.png'
  end
end
