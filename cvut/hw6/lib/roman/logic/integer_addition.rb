# frozen_string_literal: true

require_relative 'roman_class'

# Top comment
class Integer
  def roman
    Roman.arabic_to_roman(self)
  end

  def to_rom
    Roman.new(self)
  end
end
