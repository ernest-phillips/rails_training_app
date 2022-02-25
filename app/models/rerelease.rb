class Rerelease
  include ActiveModel::Model

  attr_reader :original
  attr_accessor :year

  validates_presence_of :year

  def initialize(original, params)
    @original = original
    super(params)
  end

  def id
    @result&.id
  end

  def save
    return false unless valid?
    @result = original.dup
    @result.year = year
    @result.save
  end
end

