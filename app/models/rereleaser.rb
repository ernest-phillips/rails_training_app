class Rereleaser
  attr_reader :original

  def initialize(movie)
    @original = movie
  end

  def run(params)
    original.dup.tap do |result|
      result.year = params[:year]
      result.save
    end
  end
end
