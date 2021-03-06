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

    unfilled_cells = []
    @grid.each { |cell| unfilled_cells.push(cell) unless cell.filled? }
    unfilled_cells = unfilled_cells.sort { |cell_a, cell_b| cell_a.num_possible <=> cell_b.num_possible }
    solve_using(unfilled_cells)

    @grid.solution
  end

  def solve_using(unfilled_cells)
    # unfilled_cells = []
    # cell = Cell.new
    # @grid = Grid.new
    # puts unfilled_cells.map(&:num_possible).join(',')
    cell = unfilled_cells.shift

    if unfilled_cells.empty?
      cell.possible.each do |i|
        cell.value = i
        return true if @grid.valid?(cell.pos)
      end

      return false
    end

    cell.possible.each do |i|
      cell.value = i
      next unless @grid.valid?(cell.pos)

      res = solve_using(unfilled_cells)
      return true if res
    end
    cell.value = 0
    unfilled_cells.unshift(cell)

    false
  end

  def solution
    @grid.solution
  end

  def to_s
    @grid.to_s
  end

  protected

  # Solves the given sudoku using recursion
  #
  # @param unfilled_cells [Array<Cell>] is an array of all unfilled cells
  #   in the given sudoku sorted by number of possible solutions of each cell.
  # @param cell_index [Integer] is an index in unfilled_cells that the current recursion step should check.
  #
  # @return True if the current recursion step and all its substeps are valid.
  # def rec_solve(unfilled_cells, cell_index)
  #   cell = unfilled_cells[cell_index]

  #   # Check all possible values of this cell
  #   while cell.num_possible.positive?

  #   end
  # end

  # Exclude all numbers that were preset in all cells of its row, column and block
  def exclude_preset_numbers
    @grid.each do |filled_cell|
      next unless filled_cell.filled?

      pos = filled_cell.pos

      full_exclude(pos, filled_cell.to_i)
    end
  end

  def full_exclude(pos, value)
    EXCLUDE.call(@grid.row_elems(pos.x), value)
    EXCLUDE.call(@grid.col_elems(pos.y), value)
    EXCLUDE.call(@grid.block_elems(pos.x, pos.y), value)
  end

  def load(game)
    PARSERS.each do |p|
      return p.load(game) if p.supports?(game)
    end
    raise "input '#{game}' is not supported yet"
  end
end
