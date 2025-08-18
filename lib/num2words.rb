# frozen_string_literal: true

require_relative "num2words/version"
require_relative "num2words/converter"

module Num2words
  def self.to_words(number, feminine: false)
    Converter.to_words(number, feminine: feminine)
  end

  def self.to_currency(amount)
    Converter.to_currency(amount)
  end
end
