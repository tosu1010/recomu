class LikesController < ApplicationController
  before_action :set_review, only: [:create, :destroy]

  def create
    if user_signed_in?
      like = Like.new(flag: 1, user_id: current_user.id, review_id: @review.id)
      like.save

      # ハートのアニメーションを動かすため
      sleep(0.45)
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, review_id: @review.id)
    like.delete
  end


  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
