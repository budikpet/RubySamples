# frozen_string_literal: true

require_relative 'roman_class'

# Integer additions
class Integer
  # @return [String] Returns itself as roman number
  def roman
    RomanClass.arabic_to_roman(self)
  end

  # @return [RomanClass] Returns itself as RomanClass.
  def to_rom
    RomanClass.new(self)
  end
end
