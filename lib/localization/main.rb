require "localization"

class Localization < BasicObject
  module Main
    def localize
      ::Localization.new
    end
  end
end

include ::Localization::Main
