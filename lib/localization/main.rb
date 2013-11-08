require "localization"


class Localization
  module Main
    def localize
      Localization.new
    end
  end
end

include Localization::Main
