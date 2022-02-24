module MovieRefinement
  refine String do
    def to_marquee
      "**#{self.upcase}**"
    end
  end
end
