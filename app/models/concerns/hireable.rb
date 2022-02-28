module Hireable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
  end


  class_methods do
    def can_be_hired?
      true
    end
  end

  def hire
    "#{self.name} is now working for your studio."
  end
end
