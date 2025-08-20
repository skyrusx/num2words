# frozen_string_literal: true

module Num2words
  module Locales
    module AR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ar)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ar)
      TEENS = I18n.t("num2words.teens", locale: :ar)
      TENS = I18n.t("num2words.tens", locale: :ar)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ar)
      SCALES = I18n.t("num2words.scales", locale: :ar)

      MAJOR_UNIT = I18n.t("num2words.currencies.SAR.name", locale: :ar)
      MINOR_UNIT = I18n.t("num2words.currencies.SAR.fractional.name", locale: :ar)
    end

    register :ar, AR
  end
end
