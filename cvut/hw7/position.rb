# frozen_string_literal: true

# Grid position
class Position
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "[#{@x};#{@y}]"
  end
end
