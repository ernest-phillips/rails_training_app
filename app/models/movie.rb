class Movie < ApplicationRecord
  attr_accessor :director_name

  enum :color_format => {
    :color => 0,
    :black_and_white => 1
  }

  validates_presence_of :title

  belongs_to :director, optional: true
  # * there is a class called Director - override with class_name
  # * there is a column called director_id on this model's table
  # * that column refers to the id column on directors

  before_validation :set_director_by_name

  def self.titles
    # all.map { |movie| movie.title }
    # or
    pluck(:title)
  end

  def self.sorted_by_facebook_likes
    order(facebook_likes: :desc)
  end

  def self.release_year_by_title(target_title)
    find_by(title: target_title)&.year
  end

  def self.count_with_facebook_likes(target_likes)
    where("facebook_likes > ?", target_likes).count
  end

  def rerelease(params)
    dup.tap do |result|
      result.year = params[:year]
      result.save
    end
  end

  private

  def set_director_by_name
    if director_id.blank? && director_name.present?
      self.director = Director.find_or_initialize_by(name: director_name)
    end
  end
end
