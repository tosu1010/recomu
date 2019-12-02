class Review < ApplicationRecord
  has_many :tags, through: :reviews_tags
  has_many :reviews_tags
  belongs_to :user
  belongs_to :album
end
