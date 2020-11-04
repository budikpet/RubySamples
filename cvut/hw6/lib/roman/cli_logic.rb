# frozen_string_literal: true

require_relative 'roman_class'
require_relative 'string_addition'
require_relative 'integer_addition'
require 'bundler/setup'
Bundler.require(:default)

module Roman
  # Contains logic of Thor CLI interface.
  class CLI_Logic
    # Handles --arabic option.
    # @param input [String] value of --arabic option.
    # @return [Integer] Input value in arabic numbers.
    def handle_arabic_cmd(input)
      if (input.is_a? Numeric) || input.contains_numeric?
        input = Integer(input)
        RomanClass.check_numeric(input)
        input
      else
        RomanClass.roman_to_arabic input
      end
    end

    # Handles --roman option.
    # @param input [String] value of --roman option.
    # @return [String] Input value in roman numbers.
    def handle_roman_cmd(input)
      if (input.is_a? Numeric) || input.contains_numeric?
        RomanClass.arabic_to_roman Integer(input)
      else
        raise ArgumentError, "Received value '#{input}' is not a valid roman number." unless RomanClass.roman? input

        input
      end
    end

    # Handles logic of the "roman" command.
    #
    # If both options are provided then --arabic is prefered.
    #
    # @param arabic_cmd [String] value of --arabic option
    # @param roman_cmd [String] value of --roman option
    # @return [String | Integer] If input value is valid then returns either arabic representation (for --arabic) or roman representation (for --roman). Returns error if invalid input is provided.
    def roman_method_logic(arabic_cmd, roman_cmd)
      return handle_arabic_cmd(arabic_cmd) unless arabic_cmd.nil?
      return handle_roman_cmd(roman_cmd) unless roman_cmd.nil?
    rescue ArgumentError => e
      e.message
    end
  end
end
