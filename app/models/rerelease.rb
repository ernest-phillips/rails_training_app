class Rerelease
  attr_reader :original, :params

  def initialize(original, params)
    @original = original
    @params = params
  end

  def id
    @result&.id
  end

  def year
    params[:year]
  end

  def save
    @result = original.dup
    @result.year = year
    @result.save
  end
end

