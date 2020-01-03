class ReviewsController < ApplicationController
  include SpotifyMethod

  def index
    
  end

  def new
    
  end

  def create
    spotify_auth
    
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
end
