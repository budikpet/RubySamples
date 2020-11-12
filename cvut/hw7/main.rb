# frozen_string_literal: true

require_relative 'sudoku'

g = '006002800050130020402500901900070540020801090087050002208009305040018070003600100'
sudoku = Sudoku.new(g)

sudoku.solve
puts 'DOne'
