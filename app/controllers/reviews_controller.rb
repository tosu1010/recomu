class ReviewsController < ApplicationController
  include SpotifyMethod
  def index

  end

  def new
    @review_form = ReviewForm.new
    redirect_to new_user_session_path unless user_signed_in? 
  end

  def create
    @review_form = ReviewForm.new(review_params)
    if @review_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @review = Review.includes(:album).find(params[:id])
    @comment = Comment.new
    @tracks = @review.album.spotify_id ? get_tracks(@review.album.spotify_id) : nil
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to root_path
  end

  private
  def review_params
    params.require(:review_form).permit(:artist_name, :album_name, :review_content, tags: []).merge(user_id: current_user.id)
  end

end
