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
      @amount = amount.to_i
      @code = code
      @rate = rate.sub(',', '.').to_f
    end
  end
end
