# frozen_string_literal: true

require_relative 'roman'
require_relative 'string_addition'
require_relative 'integer_addition'

def assert_equal(expected, value)
  raise "Expected result: #{expected}, got #{value}." unless expected == value
end

a = Roman.new(5)
# b = Roman.new('IV')

# Arabic -> Roman test
assert_equal('XIX', Roman.arabic_to_roman(19))
assert_equal('CDXXVI', Roman.arabic_to_roman(426))
assert_equal('CMXIX', Roman.arabic_to_roman(919))
assert_equal('MMXX', Roman.arabic_to_roman(2020))
assert_equal('XLIV', Roman.arabic_to_roman(44))
assert_equal('XLIV', Roman.arabic_to_roman(44.4))
assert_equal('XLV', Roman.arabic_to_roman(45))
assert_equal('XLV', Roman.arabic_to_roman(44.9))

# Roman -> Arabic test
assert_equal(19, Roman.roman_to_arabic('XIX'))
assert_equal(426, Roman.roman_to_arabic('CDXXVI'))
assert_equal(919, Roman.roman_to_arabic('CMXIX'))
assert_equal(2020, Roman.roman_to_arabic('MMXX'))
assert_equal(44, Roman.roman_to_arabic('XLIV'))
assert_equal(44, Roman.roman_to_arabic('xliv'))

# Arithmetic operations

assert_equal(10, a + 5)
assert_equal(10, 5 + a)
assert_equal(10, a + a)

assert_equal(0, a - 5)
assert_equal(0, 5 - a)
assert_equal(0, a - a)

assert_equal(25, a * 5)
assert_equal(25, 5 * a)
assert_equal(25, a * a)

assert_equal(1, a / 5)
assert_equal(1, 5 / a)
assert_equal(1, a / a)

roman = Roman.new(4)
assert_equal(5, 1 + roman)
assert_equal(8, roman * 2)
assert_equal(4, 16 / roman)

second = Roman.new(6)
assert_equal(10, roman + second)
assert_equal(2, second - roman)

assert_equal(13, [Roman.new(1), Roman.new(3), Roman.new(9)].sum)
assert_equal(15, [roman, 5, second].sum)

## Comparable
assert_equal(true, Roman.new(4) == 4)
assert_equal(true, Roman.new(5) > Roman.new(1))

## Special
assert_equal(1, [Roman.new(1), Roman.new(3), Roman.new(9)].min)
assert_equal(9, [Roman.new(1), Roman.new(3), Roman.new(9)].max)
assert_equal([1, 2, 3], (1..100).first(Roman.new(3)))

assert_equal('MMXX', Roman.new(2020).to_s)

# Errors

begin
  Roman.new(5645)
  raise 'Should have raised error.'
rescue ArgumentError => e
  puts "Overflow error raised with msg: #{e.message}"
end

begin
  Roman.arabic_to_roman(5645)
  raise 'Should have raised error.'
rescue ArgumentError => e
  puts "Overflow error raised with msg: #{e.message}"
end

begin
  Roman.arabic_to_roman('MXAB')
  raise 'Should have raised error.'
rescue ArgumentError => e
  puts "Overflow error raised with msg: #{e.message}"
end

begin
  Roman.roman_to_arabic('MXAI')
  raise 'Should have raised error.'
rescue ArgumentError => e
  puts "Overflow error raised with msg: #{e.message}"
end

begin
  Roman.new('MXAI')
  raise 'Should have raised error.'
rescue ArgumentError => e
  puts "Overflow error raised with msg: #{e.message}"
end

#### Integer / String patch

assert_equal('MMXX', 2020.roman)
assert_equal(2020, 'MMXX'.number)

int_to_rom = 2020.to_rom
raise 'Should be instance of Roman.' unless int_to_rom.is_a? Roman

assert_equal(2020, int_to_rom)

str_to_rom = 'MMXX'.to_rom
raise 'Should be instance of Roman.' unless str_to_rom.is_a? Roman

assert_equal(2020, str_to_rom)

puts 'All checked.'
