class Review < ApplicationRecord
  has_many :reviews_tags, dependent: :destroy
  has_many :tags, through: :reviews_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :album

  # 当該レビューに対して、引数に渡したユーザーがいいねを押しているかの判断
  def liked_by(user_id)
    likes.where(user_id: user_id).exists?
  end

  validates :content, presence: true
end
