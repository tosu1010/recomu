class Review < ApplicationRecord
  has_many :reviews_tags
  has_many :tags, through: :reviews_tags
  has_many :comments
  belongs_to :user
  belongs_to :album
end
