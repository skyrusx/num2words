# frozen_string_literal: true

module Num2words
  module Locales
    module GU
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :gu)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :gu)
      TEENS = I18n.t("num2words.teens", locale: :gu)
      TENS = I18n.t("num2words.tens", locale: :gu)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :gu)
      SCALES = I18n.t("num2words.scales", locale: :gu)

      MAJOR_UNIT = I18n.t("num2words.currencies.INR.name", locale: :gu)
      MINOR_UNIT = I18n.t("num2words.currencies.INR.fractional.name", locale: :gu)
    end

    register :gu, GU
  end
end
