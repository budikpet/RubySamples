# frozen_string_literal: true

# Top class doc comment
class Calculator
  def initialize(curr_val = 0, name = nil)
    @curr_val = curr_val
    @name = name
  end

  def add(*nums)
    nums.each do |i|
      @curr_val += i
    end
    self
  end

  def subtract(subtractor)
    @curr_val -= subtractor
    self
  end

  def multiply(multiplier)
    @curr_val *= multiplier
    self
  end

  def divide(divider)
    raise ZeroDivisionError, 'Cannot divide by zero!' if divider.zero?

    @curr_val /= divider
    self
  end

  def result
    @curr_val
  end

  def self.extreme(ext_type, arr)
    if ext_type == :max
      arr.max
    elsif ext_type == :min
      arr.min
    end
  end

  def self.number?(param)
    param.is_a? Numeric
  end

  def name
    @name&.upcase
  end

  # Base setter for @name
  attr_writer :name
end

#### Call test
calc = Calculator.new(10)
calc.name = 'Smarty'
calc.add 5
calc.add(1, 3, 4, 5)
calc.subtract 1
calc.divide 3

raise RuntimeError if calc.result != 9
raise RuntimeError if calc.name != 'SMARTY'

calc = Calculator.new
calc.add(3).subtract(2).add(8).divide(4).result

raise RuntimeError if calc.result != 9 / 4
raise RuntimeError unless calc.name.nil?

raise RuntimeError if Calculator.extreme(:max, [3, 5, 7, 5]) != 7
raise RuntimeError if Calculator.extreme(:min, [3, 5, 7, 5]) != 3
raise RuntimeError unless Calculator.extreme(:something, [3, 5, 7, 5]).nil?
raise RuntimeError if Calculator.number? 'foo'
raise RuntimeError unless Calculator.number? 5.2

# Check exception
begin
  calc.divide(0)
  raise RuntimeError
rescue ZeroDivisionError
  puts 'Code checked successfully.'
end
