# frozen_string_literal: true

require_relative 'sudoku'

g_easy = '010780000090600045002500100000000567800020003136000000007009400620007050000051030'
g_hard = '.....3.17.15..9..8.6.......1....7.....9...2.....5....4.......2.5..6..34.34.2.....'
sudoku = Sudoku.new(g_hard)

sudoku.solve
puts 'DOne'
