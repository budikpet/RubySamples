# frozen_string_literal: true

require_relative 'currency_convertor/cli_logic'
require 'bundler/setup'
require 'thor'

module CurrencyConvertor
  CZK_CODE = 'CZK'
  # Thor CLI interface for currency_convertor CLI utility.
  class CLI < Thor
    desc 'convert [OPTIONS]', ''
    long_desc <<-LONGDESC
      Converts given value between 2 currencies using current prices from ČNB.
    LONGDESC
    method_option :amount, type: :numeric, aliases: '-v', required: true, desc: 'Amount of money in the input currency.'
    method_option :input_currency, type: :string, aliases: '-i', required: true, desc: 'Code of the input currency.'
    method_option :output_currency, type: :string, aliases: '-o', default: CZK_CODE, desc: 'Code of the output currency.'
    def convert
      cli_logic = CLI_Logic.new

      begin
        cli_logic.convert(options[:amount], options[:input_currency], options[:output_currency])
      rescue ArgumentError => e
        puts "ERROR OCCURED: #{e.message}"
        puts ''
        CLI.command_help(Thor::Base.shell.new, 'convert')
      end
    end

    desc 'currencies [OPTIONS]', ''
    long_desc <<-LONGDESC
      Gets all supported currencies.
    LONGDESC
    def currencies
      cli_logic = CLI_Logic.new

      begin
        cli_logic.currencies
      rescue ArgumentError => e
        puts "ERROR OCCURED: #{e.message}"
        puts ''
        CLI.command_help(Thor::Base.shell.new, 'currencies')
      end
    end
  end
end
