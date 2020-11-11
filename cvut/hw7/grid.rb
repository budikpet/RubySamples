# frozen_string_literal: true

# Contains sudoku game board
class Grid
  include Enumerable

  EMPTY_VAL = 0

  # Create Sudoku game grid of given dimension
  def initialize(dimension)
    @dimension = dimension
    @data = Array.new(dimension) { Array.new(dimension) { EMPTY_VAL } }
  end

  # Return string with game board in a console friendly format
  def to_s(width = 3); end

  # First element in the sudoku grid
  def first
    @data[0][0]
  end

  # Last element in the sudoku grid
  def last
    @data[-1][-1]
  end

  # Return value at given position
  def value(x, y)
    @data[x][y]
  end

  # Marks number +z+ which shouldn't be at position [x, y]
  def exclude(x, y, z); end

  # True when there is already a number
  def filled?(x, y)
    @data[x][y] != EMPTY_VAL
  end

  # True when no game was loaded
  def empty?; end

  # Yields elements in given row
  def row_elems(x)
    return enum_for(:row_elems, x) unless block_given?

    # TODO: more code here
  end

  # Yields elements in given column
  def col_elems(y)
    return enum_for(:col_elems, y) unless block_given?

    # TODO: more code here
  end

  # Yields elements from block which is
  # containing element at given position
  def block_elems(x, y)
    return enum_for(:block_elems, x, y) unless block_given?

    # TODO: more code here
  end

  # With one argument return row, with 2, element
  # at given position
  def [](*args)
    x = args[0]
    y = args[1]
    args.size == 1 ? @data[x] : @data[x][y]
  end

  # With one argument sets row, with 2 element
  def []=(*args)
    x = args[0]

    if args.size == 2
      @data[x] = args[1]
    else
      y = args[1]
      @data[x][y] = args[2]
    end
  end

  # Return number of missing numbers in grid
  def missing
    @data.flatten(1).select { |num| num == EMPTY_VAL }.size
  end

  # Number of filled cells
  def filled
    rows * cols - missing
  end

  # Number of rows in this sudoku
  def rows
    @dimension
  end

  # Number of columns in this sudoku
  def cols
    @dimension
  end

  # Iterates over all elements, left to right, top to bottom
  def each
    return enum_for(:each) unless block_given?

    # TODO: more code here
  end

  # Return true if no filled number break sudoku rules
  def valid?; end

  # Serialize grid values to a one line string
  def solution; end
end
