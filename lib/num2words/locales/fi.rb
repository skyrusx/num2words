# frozen_string_literal: true

module Num2words
  module Locales
    module FI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :fi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :fi)
      TEENS = I18n.t("num2words.teens", locale: :fi)
      TENS = I18n.t("num2words.tens", locale: :fi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :fi)
      SCALES = I18n.t("num2words.scales", locale: :fi)

      RUB = I18n.t("num2words.currencies.EUR.name", locale: :fi)
      KOP = I18n.t("num2words.currencies.EUR.fractional.name", locale: :fi)
    end

    register :fi, FI
  end
end
