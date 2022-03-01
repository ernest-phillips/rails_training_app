class Actor < ApplicationRecord
  include Hireable
  has_many :castings
  has_many :movies, through: :castings
end
