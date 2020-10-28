# frozen_string_literal: true

class Roman
  ROMAN_NUMBERS = {
    1000 => 'M',
    900 => 'CM',
    500 => 'D',
    400 => 'CD',
    100 => 'C',
    90 => 'XC',
    50 => 'L',
    40 => 'XL',
    10 => 'X',
    9 => 'IX',
    5 => 'V',
    4 => 'IV',
    1 => 'I'
  }.freeze

  MAX_VALUE = 4000
  MIN_VALUE = 1

  attr_accessor :arab_value
  attr_accessor :roman_value

  def initialize(value)

    if value.is_a? String
      value = value.upcase

      @roman_value = value
      @arab_value = Roman.roman_to_arabic(value)
    else
      Roman.test_range_overflow(value)

      @arab_value = value
      @roman_value = Roman.arabic_to_roman(value)
    end
  end

  def self.roman_to_arabic(roman_value)
    res = 0
    ROMAN_NUMBERS.each do |arabic, roman|
      while roman_value.start_with?(roman)
        res += arabic
        roman_value = roman_value[roman.length..-1]
      end
    end

    res
  end

  def self.arabic_to_roman(arab_value)
    Roman.test_range_overflow(arab_value)

    arab_value = arab_value.round

    res = ''
    ROMAN_NUMBERS.each do |arabic, roman|
      next unless arabic <= arab_value

      div = arab_value / arabic
      arab_value -= arabic * div
      res += roman * div
    end

    res
  end

  def self.test_range_overflow(value)
    raise "Value out of range [#{min_value}, #{max_value}]" unless value.between?(MIN_VALUE, MAX_VALUE)
  end

  def max_roman_number
    ROMAN_NUMBERS.keys.max
  end

  #### Arithmetic operations

  def +(other)
    other + @arab_value
  end

  def -(other)
    other - @arab_value
  end

  def *(other)
    other * @arab_value
  end

  def /(other)
    other / @arab_value
  end

  def coerce(other)
    [self, other]
  end

  ####
end
