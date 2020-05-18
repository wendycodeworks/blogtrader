class Blog < ApplicationRecord
  belongs_to :user
  has_many :blogs_topics
  has_many :topics, through: :blogs_topics 
  has_one_attached :picture
  has_many :favourites
end

