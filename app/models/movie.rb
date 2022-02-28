class Movie < ApplicationRecord
  using MovieRefinement

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

  has_many :castings
  has_many :actors, through: :castings

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

  scope :with_more_facebook_likes, -> (target_likes) { where("facebook_likes > ?", target_likes) }

  def self.count_with_facebook_likes(target_likes)
    with_more_facebook_likes(target_likes).count
  end

  scope :directed_by, -> (director_name) { joins(:director).where(directors: {name: director_name }) }

  scope :with_plot_keyword, -> (keyword) { where("plot_keywords LIKE ?", "%#{keyword}%") }

  scope :with_most_facebook_likes, -> { order(facebook_likes: :desc).limit(1) }

  def to_marquee
    title.to_marquee
  end

  def method_missing(method_name, *args, &block)
    # Alternate:
    # if method_name.to_s.match /^is_in_(.*)$/
    #   send($1)
    # else
    #   super
    # end

    if method_name.to_s.start_with?("is_in_")
      short_name = method_name.to_s.gsub(/^is_in_/,"")
      send(short_name)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?("is_in_") || super
  end

  private

  def set_director_by_name
    if director_id.blank? && director_name.present?
      self.director = Director.find_or_initialize_by(name: director_name)
    end
  end
end
