class ReviewsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def create
    Review.transaction do
      artist = Artist.find_or_create_by!(name: review_params[:artist])
      album = Album.find_or_create_by!(title: review_params[:album], artist_id: artist.id)
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
      flash[:failed] = "登録に失敗しました"
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
