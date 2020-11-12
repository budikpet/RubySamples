# frozen_string_literal: true

require_relative './grid'
require_relative 'cell'
require_relative 'position'
# Parse string for 9x9 sudoku game
class StringParser
  # Static methods will follow
  class << self
    # Return true if passed object
    # is supported by this loader
    # Supports strings of exactly 81 numbers either [0-9] or ([1-9] and ".") where 0 or "." are empty spaces.
    def supports?(arg)
      return false if arg.nil?
      return false unless arg.is_a? String
      return false unless arg.size == 81

      if arg.match(/\D/)
        # Contains non-numeric character
        return arg.scan(/\D/).reject { |c| c == '.' }.size.zero?
      end

      true
    end

    # Return Grid object when finished
    # parsing
    # @param arg [String] a supported String value where first character is  [0,0], second is [0,1]...
    def load(arg)
      return nil unless supports? arg

      dimension = 9
      grid = Grid.new(dimension)

      x = 0
      y = 0

      arg.each_char do |char|
        grid[x][y] = Cell.new(char.to_i, dimension, Position.new(x, y))

        y += 1
        if (y % dimension).zero?
          y = 0
          x += 1
        end
      end

      grid
    end
  end
end
