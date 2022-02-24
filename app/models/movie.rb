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

  def rerelease(params)
    rerelease = dup
    rerelease.year = params[:year]
    rerelease.save
    
    rerelease
  end

  def self.titles
    pluck(:title)
  end

  def self.sorted_by_facebook_likes
    order(facebook_likes: :desc)
  end

  def self.release_year_by_title(target_title)
    find_by(title: target_title)&.year
  end

  scope :with_more_facebook_likes, -> (target_likes) { where("facebook_likes > ?", target_likes) }

  def self.count_with_facebook_likes(target_likes)
    with_more_facebook_likes(target_likes).count
  end

  scope :directed_by, -> (director_name) { joins(:director).where(directors: {name: director_name }) }

  scope :with_plot_keyword, -> (keyword) { where("plot_keywords LIKE ?", "%#{keyword}%") }

  scope :with_most_facebook_likes, -> { order(facebook_likes: :desc).limit(1) }

  private

  def set_director_by_name
    if director_id.blank? && director_name.present?
      self.director = Director.find_or_initialize_by(name: director_name)
    end
  end
end
