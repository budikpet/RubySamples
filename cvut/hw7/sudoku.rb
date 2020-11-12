# frozen_string_literal: true

require_relative './grid'
require_relative './string_parser'

# Basic sudoku solver
class Sudoku
  PARSERS = [StringParser].freeze

  EXCLUDE = proc do |enum, val|
    enum.each do |e|
      e.exclude(val)
    end
  end

  attr_reader :grid

  def initialize(game)
    # @grid = Grid.new
    @grid = load(game)
  end

  # Return true when there is no missing number
  def solved?
    !@grid.nil? && @grid.missing.zero?
  end

  # Solves sudoku and returns 2D Grid
  def solve
    raise 'invalid game given' unless @grid.valid?

    exclude_preset_numbers
  end

  def to_s
    @grid.to_s
  end

  # Exclude all numbers that were preset in all cells of its row, column and block
  private def exclude_preset_numbers
    @grid.each do |filled_cell|
      next unless filled_cell.filled?

      pos = filled_cell.pos

      @grid.row_elems(pos.x).reject(&:filled?).each { |cell| cell.exclude filled_cell.to_i }
      @grid.col_elems(pos.y).reject(&:filled?).each { |cell| cell.exclude filled_cell.to_i }
      @grid.block_elems(pos.x, pos.y).reject(&:filled?).each { |cell| cell.exclude filled_cell.to_i }
    end
  end

  protected

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    raise "input '#{game}' is not supported yet"
  end
end
