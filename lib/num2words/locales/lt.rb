# frozen_string_literal: true

module Num2words
  module Locales
    module LT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :lt)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :lt)
      TEENS = I18n.t("num2words.teens", locale: :lt)
      TENS = I18n.t("num2words.tens", locale: :lt)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :lt)
      SCALES = I18n.t("num2words.scales", locale: :lt)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :lt)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :lt)
    end

    register :lt, LT
  end
end
