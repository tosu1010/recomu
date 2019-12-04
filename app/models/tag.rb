class Tag < ApplicationRecord
  has_many :reviews_tags
  has_many :reviews, through: :reviews_tags

  def self.find_tag(names)
    tags = []
    names.each do |name|
      tag = Tag.find_by(name: name)
      unless tag.present?
        tag = Tag.create!(name: name)
      end
      tags << tag
    end
    tags
  end
end
