class BlogsTopic < ApplicationRecord
    belongs_to :blog
    belongs_to :topic
end