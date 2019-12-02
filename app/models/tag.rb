class Tag < ApplicationRecord
  has_many :reviews, through: :reviews_tags
  has_many :reviews_tags
end
