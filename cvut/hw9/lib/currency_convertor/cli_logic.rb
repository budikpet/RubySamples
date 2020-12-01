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
    def convert(amount, input_currency, output_currency)
      raise ArgumentError, 'Amount should be >= 0.' unless amount.positive?
      if input_currency == output_currency
        raise ArgumentError, "Both currencies are equal to '#{input_currency}'. They must differ."
      end

      currencies_data = CurrenciesData.new

      # Check if currencies supported
      unless currencies_data.currency_supported?(input_currency)
        raise ArgumentError, "Unknown code [#{input_currency}] of input currency."
      end
      unless currencies_data.currency_supported?(output_currency)
        raise ArgumentError, "Unknown code [#{output_currency}] of output currency."
      end

      if input_currency != CurrencyConvertor::CZK_CODE && output_currency != CurrencyConvertor::CZK_CODE
        # Conversion between two currencies that aren't czech crowns. Need to do input_currency -> CZK and CZK -> output_currency
        output_czk = do_conversion(amount, input_currency, CurrencyConvertor::CZK_CODE, currencies_data)
        output_amount = do_conversion(output_czk, CurrencyConvertor::CZK_CODE, output_currency, currencies_data)
      else
        output_amount = do_conversion(amount, input_currency, output_currency, currencies_data)
      end

      puts output_amount
    end

    # Contains logic of currencies CLI command.
    # Return names and codes of all supported currencies.
    def currencies
      currencies_data = CurrenciesData.new

      currencies_data.data.each do |code, currency_data|
        puts "Měna '#{currency_data.name}' [#{code}] ze země #{currency_data.country}. Kurz #{currency_data.amount}#{code} -> #{currency_data.rate}#{CurrencyConvertor::CZK_CODE}"
      end
    end

    private

    # Does conversion CZK -> currency or currency -> CZK.
    # @return [Numeric] A converted amount.
    def do_conversion(amount, input_currency, output_currency, currencies_data)
      if output_currency == CurrencyConvertor::CZK_CODE
        currency_data = currencies_data.data[input_currency]
        (amount / currency_data.amount.to_f) * currency_data.rate
      elsif input_currency == CurrencyConvertor::CZK_CODE
        currency_data = currencies_data.data[output_currency]
        (amount / currency_data.rate) * currency_data.amount
      end
    end
  end
end
