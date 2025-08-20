# frozen_string_literal: true

module Num2words
  module Locales
    module DA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :da)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :da)
      TEENS = I18n.t("num2words.teens", locale: :da)
      TENS = I18n.t("num2words.tens", locale: :da)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :da)
      SCALES = I18n.t("num2words.scales", locale: :da)

      MAJOR_UNIT = I18n.t("num2words.currencies.DKK.name", locale: :da)
      MINOR_UNIT = I18n.t("num2words.currencies.DKK.fractional.name", locale: :da)
    end

    register :da, DA
  end
end
