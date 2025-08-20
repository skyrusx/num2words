# frozen_string_literal: true

module Num2words
  module Locales
    module HI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hi)
      TEENS = I18n.t("num2words.teens", locale: :hi)
      TENS = I18n.t("num2words.tens", locale: :hi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hi)
      SCALES = I18n.t("num2words.scales", locale: :hi)

      MAJOR_UNIT = I18n.t("num2words.currencies.INR.name", locale: :hi)
      MINOR_UNIT = I18n.t("num2words.currencies.INR.fractional.name", locale: :hi)
    end

    register :hi, HI
  end
end
