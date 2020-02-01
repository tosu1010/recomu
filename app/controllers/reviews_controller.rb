class ReviewsController < ApplicationController
  include SpotifyMethod
  def index

  end

  def new
    @review_form = ReviewForm.new
    unless user_signed_in?
      flash[:alert] = 'ログインが必要です'
      redirect_to new_user_session_path
    end
  end

  def create
    @review_form = ReviewForm.new(review_params)
    path = Rails.application.routes.recognize_path(request.referer)
    if @review_form.save
      if path[:controller] == 'albums'
        flash[:notice] = 'レビューを投稿しました'
        redirect_to album_path(path[:id])
      else
        flash[:notice] = 'レビューを投稿しました'
        redirect_to root_path
      end
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
    if review.destroy
      if review.album.reviews.count == 0
        flash[:warning] = 'レビューを削除しました'
        redirect_to root_path
      else
        flash[:warning] = 'レビューを削除しました'
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:warning] = 'レビューを削除できませんでした'
    end
  end

  private
  def review_params
    params.require(:review_form).permit(:artist_name, :album_name, :review_content, tags: []).merge(user_id: current_user.id)
  end

end
