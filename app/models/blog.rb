class Blog < ApplicationRecord
  belongs_to :user
  has_many :blogs_topics
  has_many :topics, through: :blogs_topics 
end
