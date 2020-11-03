# frozen_string_literal: true

require_relative 'roman_class'

# Top comment
class String
  def number
    Roman.roman_to_arabic(self)
  end

  def to_rom
    Roman.new(self)
  end

  def contains_numeric?
    !Float(self).nil?
  rescue StandardError
    false
  end
end
