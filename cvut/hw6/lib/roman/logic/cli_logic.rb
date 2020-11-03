# frozen_string_literal: true

require_relative 'logic/roman_class'
require_relative 'logic/string_addition'
require_relative 'logic/integer_addition'

def roman_method_logic(arabic, roman)
  if arabic.nil? && roman.nil?
    CLI.command_help(Thor::Base.shell.new, 'roman')
    return
  end

  unless arabic.nil?
    if arabic.contains_numeric?
      arabic
    else
      RomanClass.roman_to_arabic arabic
    end
  end
end
