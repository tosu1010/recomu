class Tag < ApplicationRecord
  has_many :reviews_tags
  has_many :reviews, through: :reviews_tags

  def self.find_tag(names)
    tags = []
    names.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      tags << tag
    end
    tags
  end

  def self.search(name)
    Tag.where('name LIKE(?)', "%#{name}%")
  end

  validates :name, presence: true
end
