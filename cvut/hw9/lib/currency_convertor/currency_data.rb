# frozen_string_literal: true

module CurrencyConvertor
  class CurrencyData

    attr_accessor :country
    attr_accessor :name
    attr_accessor :amount
    attr_accessor :code
    attr_accessor :rate

    def initialize(country, name, amount, code, rate)
      @country = country
      @name = name
      @amount = amount
      @code = code
      @rate = rate
    end
  end
end
