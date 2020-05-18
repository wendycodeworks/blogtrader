class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  validates_uniqueness_of :user, scope: :blog, message: "Already favourited"
end
