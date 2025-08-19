# frozen_string_literal: true

require_relative "num2words/i18n"
require_relative "num2words/version"
require_relative "num2words/converter"
require_relative "num2words/core_ext"
require_relative "num2words/locales"

module Num2words
  def self.to_words(number, feminine: false)
    Converter.to_words(number, feminine: feminine)
  end

  def self.to_currency(amount)
    Converter.to_currency(amount)
  end
end
