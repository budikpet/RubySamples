# frozen_string_literal: true

require_relative 'roman_class'
require_relative 'string_addition'
require_relative 'integer_addition'

def handle_arabic(input)
  if input.contains_numeric?
    input
  else
    RomanClass.roman_to_arabic input
  end
end

def handle_roman(input)
  if input.contains_numeric?
    RomanClass.arabic_to_roman Float(input)
  else
    RomanClass.roman_to_arabic input
  end
end

def roman_method_logic(arabic, roman)
  if arabic.nil? && roman.nil?
    CLI.command_help(Thor::Base.shell.new, 'roman')
    return
  end

  begin
    return handle_arabic(arabic) unless arabic.nil?
    return handle_roman(roman) unless roman.nil?
  rescue ArgumentError => e
    e.message
  end
end
