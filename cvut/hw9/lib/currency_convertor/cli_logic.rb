# frozen_string_literal: true

require 'set'
require_relative 'currencies_data'

# Main module of currency_convertor CLI and it's logic.
module CurrencyConvertor
  # Implements logic of the created CLI command.
  class CLI_Logic
    # Contains logic of convert CLI command.
    # Converts amount of money between two currencies.
    # @param amount [Numeric] - amount of money to convert from input currency to output currency
    # @param input_currency [String] - code of the input currency
    # @param output_currency [String] - code of the output currency
    def convert(amount, _input_currency, _output_currency)
      raise ArgumentError, 'Amount should be >= 0.' unless amount.positive?
      
      currencies_data = CurrenciesData.new
      currencies_data
    end

    # Contains logic of currencies CLI command.
    # Return names and codes of all supported currencies.
    def currencies
      currencies_data = CurrenciesData.new

      currencies_data.data.each do |code, currency_data|
        puts "Měna '#{currency_data.name}' [#{code}] ze země #{currency_data.country}."
      end
    end
  end
end
