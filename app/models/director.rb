class Director < ApplicationRecord
  include Hireable
  validates_presence_of :name

  has_many :movies
  # * there is a class called Movie - override with class_name
  # * it has a column called director_id - override with foreign_key
  # * the column on movies called director_id refers to the column named id on this table - override with primary_key
end
