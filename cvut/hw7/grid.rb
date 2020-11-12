# frozen_string_literal: true

# Contains sudoku game board
class Grid
  include Enumerable

  # Create Sudoku game grid of given dimension
  def initialize(dimension)
    @dimension = dimension
    @data = Array.new(dimension) { Array.new(dimension) }
  end

  # Return string with game board in a console friendly format
  def to_s(width = 3)
    rows = []
    leading_spaces = ((width - 1) / 2).times.collect { ' ' }.join('')

    ## Prepare row divider
    block_row_div = (width * block_size).times.collect { '-' }.join('')
    row_div = block_size.times.collect { block_row_div }.join('+')

    @data.each do |row|
      rows.push row_div if (row[0].pos.x % block_size).zero?
      curr_row = get_curr_row_s(row, leading_spaces)

      rows.push curr_row
    end

    rows.push row_div
    rows.join("\n")
  end

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
    @data[x][y].to_i
  end

  # Marks number +z+ which shouldn't be at position [x, y]
  def exclude(x, y, z)
    @data[x][y].exclude z
  end

  # True when there is already a number
  def filled?(x, y)
    @data[x][y].filled?
  end

  # True when no game was loaded
  def empty?
    @data.select(&:nil?).empty?
  end

  # Yields elements in given row
  def row_elems(x)
    return enum_for(:row_elems, x) unless block_given?

    @data[x].each { |cell| yield cell }
  end

  # Yields elements in given column
  def col_elems(y)
    return enum_for(:col_elems, y) unless block_given?

    @data.each { |r| yield r[y] }
  end

  # Yields elements from block which is
  # containing element at given position
  def block_elems(x, y)
    return enum_for(:block_elems, x, y) unless block_given?

    x -= x % block_size
    y -= y % block_size

    (x...(x + block_size)).each do |curr_x|
      (y...(y + block_size)).each do |curr_y|
        yield @data[curr_x][curr_y]
      end
    end
  end

  # Yields elements from block which is
  # containing element at given position
  def block(block_pos)
    return enum_for(:block, block_pos) unless block_given?

    y = (block_pos * block_size) % rows
    x = ((block_pos * block_size) / cols) * block_size

    (x...(x + block_size)).each do |curr_x|
      (y...(y + block_size)).each do |curr_y|
        yield @data[curr_x][curr_y]
      end
    end
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
    rows * cols - filled
  end

  # Number of filled cells
  def filled
    @data.flatten(1).select(&:filled?).size
  end

  # Number of rows in this sudoku
  def rows
    @dimension
  end

  # Number of columns in this sudoku
  def cols
    @dimension
  end

  def block_size
    Math.sqrt(cols).to_i
  end

  # Iterates over all elements, left to right, top to bottom
  def each
    return enum_for(:each) unless block_given?

    @data.each { |r| r.each { |cell| yield cell } }
  end

  # Return true if no filled number break sudoku rules
  def valid?(pos = nil)
    return cell_valid?(@data[pos.x][pos.y]) unless pos.nil?

    each do |cell|
      if cell.filled?
        return false unless cell_valid?(cell)
      end
    end

    true
  end

  # Serialize grid values to a one line string
  def solution
    arr = []
    each { |cell| arr.push cell.to_i }
    arr.join('')
  end

  private

  def cell_valid?(cell)
    pos = cell.pos
    return false unless row_elems(pos.x).map(&:to_i).select { |i| i == cell.to_i }.size == 1
    return false unless col_elems(pos.y).map(&:to_i).select { |i| i == cell.to_i }.size == 1
    return false unless block_elems(pos.x, pos.y).map(&:to_i).select { |i| i == cell.to_i }.size == 1

    true
  end

  def get_curr_row_s(row, leading_spaces)
    res = row.map(&:to_i)
             .join('')
             .gsub(/(\d\d\d)/, '\1 ')
             .strip
             .split(' ')

    res = res.map do |box_str|
      res = box_str.split('')
      res = res.map do |num|
        num = num.to_i.zero? ? ' ' : num
        "#{leading_spaces}#{num}#{leading_spaces}"
      end

      res.join('')
    end

    res.join('|')
  end
end
