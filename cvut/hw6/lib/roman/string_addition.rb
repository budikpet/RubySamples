# frozen_string_literal: true

require_relative 'roman_class'

# String additions
class String
  # @return [Integer] Returns itself (should be a String with roman numbers) as arabic number.
  def number
    RomanClass.roman_to_arabic(self)
  end

  # @return [RomanClass] Returns itself as RomanClass.
  def to_rom
    RomanClass.new(self)
  end

  def contains_numeric?
    !Float(self).nil?
  rescue StandardError
    false
  end
end
