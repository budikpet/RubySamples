# frozen_string_literal: true

# Top level comment
class RomanClass
  include Comparable

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

  MAX_VALUE = 3999
  MIN_VALUE = 1

  attr_reader :arab_value
  attr_reader :roman_value
  alias to_int arab_value
  alias to_i arab_value
  alias to_s roman_value

  def arab_value=(arab_value)
    @roman_value = RomanClass.arabic_to_roman(arab_value)
    @arab_value = arab_value
  end

  def roman_value=(roman_value)
    roman_value = roman_value.upcase
    @arab_value = RomanClass.roman_to_arabic(roman_value)
    @roman_value = roman_value
  end

  def initialize(value)
    if value.is_a? String
      value = value.upcase
      @arab_value = RomanClass.roman_to_arabic(value)
      @roman_value = value
    else
      @roman_value = RomanClass.arabic_to_roman(value)
      @arab_value = value
    end
  end

  def self.roman_to_arabic(roman_value)
    raise ArgumentError, "Value should be a String, got #{roman_value}." unless roman_value.is_a? String

    res = 0
    roman_value = roman_value.upcase

    # Run until roman_value has no more characters
    until roman_value.length.zero?
      ROMAN_NUMBERS.each do |arabic, roman|
        first_c = roman_value[0, 1]
        raise ArgumentError, "Character '#{first_c}' not a roman number." unless ROMAN_NUMBERS.value? first_c

        while roman_value.start_with?(roman)
          res += arabic
          roman_value = roman_value[roman.length..-1]
        end
        break if roman_value.length.zero?
      end
    end

    # raise ArgumentError, "Input value contains characters '#{roman_value}' which were either out of order or " unless roman_value.length.zero?

    res
  end

  def self.arabic_to_roman(arab_value)
    check_numeric(arab_value)

    res = ''
    arab_value = arab_value.round
    ROMAN_NUMBERS.each do |arabic, roman|
      next unless arabic <= arab_value

      div = arab_value / arabic
      arab_value -= arabic * div
      res += roman * div
    end

    res
  end

  def self.check_numeric(num)
    raise ArgumentError, "Value should be numeric, got #{num}." unless num.is_a? Numeric
    unless num.between?(MIN_VALUE, MAX_VALUE)
      raise ArgumentError, "Value #{num} out of range [#{MIN_VALUE}, #{MAX_VALUE}]."
    end
  end

  def self.roman?(str)
    raise ArgumentError, "Value #{str} has to be string." unless str.is_a? String

    str = str.upcase

    # Check if all characters are roman numbers
    str.split('').each do |char|
      return false unless ROMAN_NUMBERS.value? char
    end

    true
  end

  def max_roman_number
    ROMAN_NUMBERS.keys.max
  end

  #### Arithmetic operations

  def +(other)
    @arab_value + other
  end

  def -(other)
    @arab_value - other
  end

  def *(other)
    @arab_value * other
  end

  def /(other)
    @arab_value / other
  end

  def coerce(other)
    [other, to_int]
  end

  ####

  #### Comparable

  def <=>(other)
    # return nil unless other.respond_to? :score

    if other.is_a? Integer
      @arab_value <=> other
    elsif other.is_a? RomanClass
      @arab_value <=> other.arab_value
    elsif other.is_a? String
      @roman_value.to_sym <=> other.to_sym
    end
  end

  ####
end
