# frozen_string_literal: true

class Roman
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

  MAX_VALUE = 4000
  MIN_VALUE = 1

  attr_accessor :arab_value
  attr_accessor :roman_value

  def initialize(value)
    if value.is_a? String
      @roman_value = value.upcase
      @arab_value = Roman.roman_to_arabic(value)
    else
      @arab_value = value
      @roman_value = Roman.arabic_to_roman(value)
    end
  end

  def self.roman_to_arabic(roman_value)
    raise ArgumentError, "Value should be a String, got #{roman_value}." unless roman_value.is_a? String

    res = 0
    roman_value = roman_value.upcase
    ROMAN_NUMBERS.each do |arabic, roman|
      first_c = roman_value[0, 1]
      raise ArgumentError, "Character '#{first_c}' not a roman number." unless ROMAN_NUMBERS.value? first_c

      while roman_value.start_with?(roman)
        res += arabic
        roman_value = roman_value[roman.length..-1]
      end

      break if roman_value.length.zero?
    end

    res
  end

  def self.arabic_to_roman(arab_value)
    raise ArgumentError, "Value should be numeric, got #{arab_value}." unless arab_value.is_a? Numeric
    unless arab_value.between?(MIN_VALUE, MAX_VALUE)
      raise ArgumentError, "Value #{arab_value} out of range [#{MIN_VALUE}, #{MAX_VALUE}]."
    end

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

  def max_roman_number
    ROMAN_NUMBERS.keys.max
  end

  def to_int
    @arab_value
  end

  def to_i
    @arab_value
  end

  def to_s
    @roman_value
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

  #### Comparable

  def <=>(other)
    # return nil unless other.respond_to? :score

    if other.is_a? Integer
      @arab_value <=> other
    elsif other.is_a? Roman
      @arab_value <=> other.arab_value
    end
  end

  ####
end
