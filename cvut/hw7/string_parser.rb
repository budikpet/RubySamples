# frozen_string_literal: true

require_relative './grid'
# Parse string for 9x9 sudoku game
class StringParser
  # Static methods will follow
  class << self
    # Return true if passed object
    # is supported by this loader
    def supports?(arg)
    end

    # Return Grid object when finished
    # parsing
    def load(arg)
    end
  end
end
