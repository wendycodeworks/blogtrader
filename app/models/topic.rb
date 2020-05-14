class Topic < ApplicationRecord
    has_many :blogs_topics
    has_many :blogs, through: :blogs_topics 
end
