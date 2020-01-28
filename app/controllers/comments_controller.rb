class CommentsController < ApplicationController
  before_action :set_review, only: [:create]

  def create
    if user_signed_in?
      @comment = @review.comments.new(comment_params)
      if @comment.save
        respond_to do |format|
          format.json
          format.html { redirect_to review_path(@review) }
        end
      else
        flash[:alert] = '文字を入力してください'
      end
    else
      flash[:alert] = 'ログインが必要です'
      redirect_to new_user_session_path
    end
  end

  def new

  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, review_id: @review.id)
  end

  def set_review
    @review = Review.find(params[:review_id])
  end
end
