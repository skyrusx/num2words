# frozen_string_literal: true

module Num2words
  module Locales
    module SL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sl)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sl)
      TEENS = I18n.t("num2words.teens", locale: :sl)
      TENS = I18n.t("num2words.tens", locale: :sl)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sl)
      SCALES = I18n.t("num2words.scales", locale: :sl)

      RUB = I18n.t("num2words.currencies.EUR.name", locale: :sl)
      KOP = I18n.t("num2words.currencies.EUR.fractional.name", locale: :sl)
    end

    register :sl, SL
  end
end
