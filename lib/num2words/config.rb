# frozen_string_literal: true

module Num2words
  class Config
    attr_accessor :currency_warnings

    def initialize
      reset!
    end

    def default_currency(locale = nil, currency = nil)
      if currency
        currency = currency.to_s.upcase.to_sym
        available = available_currencies(locale)

        if available.include?(currency)
          locale ? @local_currency[locale] = currency : @global_currency = currency
        elsif currency_warnings
          warn "[num2words] Currency #{currency} not available for locale #{locale.inspect}, keeping current."
        end
      end

      locale ? (@local_currency[locale] || available_currencies(locale).first || @global_currency) : @global_currency
    end

    def available_currencies(locale = I18n.locale)
      I18n.t("num2words.currencies", locale: locale).keys.map(&:to_sym)
    end

    def reset!(locale = nil)
      return @local_currency.delete(locale) if locale

      @global_currency   = available_currencies.first
      @local_currency    = {}
      @currency_warnings = true
    end
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset!
    config.reset!(locale)
  end

  def self.default_currency(locale = nil, currency = nil)
    config.default_currency(locale, currency)
  end

  def self.available_currencies(locale = I18n.locale)
    config.available_currencies(locale)
  end

  def self.currency_warnings
    config.currency_warnings
  end

  def self.currency_warnings=(value)
    config.currency_warnings = value
  end
end
