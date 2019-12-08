class CommentsController < ApplicationController
  before_action :set_review, only: [:create]

  def create
    @comment = @review.comments.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to }
        format.json
      end
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
