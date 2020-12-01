# frozen_string_literal: true

require 'net/http'
require 'json'
require 'csv'
require 'pathname'
require_relative 'currency_data'

module CurrencyConvertor
  class CurrenciesData
    ENDPOINT = 'https://www.cnb.cz/cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/denni_kurz.txt'

    attr_reader :data

    def initialize
      res = Net::HTTP.get(URI(ENDPOINT))
      csv = CSV.parse(res, col_sep: '|', encoding: 'utf-8')

      data = csv[2..-1].map do |array|
        CurrencyData.new(*array)
      end

      @data = data.map { |currency_data| [currency_data.code, currency_data] }.to_h
    end

    def currency_supported?(currency_code)
      currency_code == CurrencyConvertor::CZK_CODE || @data.key?(currency_code)
    end
  end
end
