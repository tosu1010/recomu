class ReviewsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def create
    artist = Artist.find_artist(review_params[:artist])
    album = Album.create_album(review_params[:album], artist.id)
    Review.create(
      content: review_params[:review],
      user_id: current_user.id,
      album_id: album.id,
      artist_id: artist.id
    )
  end

  def show
    
  end


  private
  def review_params
    params.permit(:album, :artist, :review)
  end
end
