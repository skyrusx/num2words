# frozen_string_literal: true

module Num2words
  module Locales
    module RU
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ru)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ru)
      TEENS = I18n.t("num2words.teens", locale: :ru)
      TENS = I18n.t("num2words.tens", locale: :ru)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ru)
      SCALES = I18n.t("num2words.scales", locale: :ru)

      RUB = I18n.t("num2words.currencies.RUB.name", locale: :ru)
      KOP = I18n.t("num2words.currencies.RUB.fractional.name", locale: :ru)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ru)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ru)
    end

    register :ru, RU
  end
end
