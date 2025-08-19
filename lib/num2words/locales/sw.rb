# frozen_string_literal: true

module Num2words
  module Locales
    module SW
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sw)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sw)
      TEENS = I18n.t("num2words.teens", locale: :sw)
      TENS = I18n.t("num2words.tens", locale: :sw)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sw)
      SCALES = I18n.t("num2words.scales", locale: :sw)

      RUB = I18n.t("num2words.currencies.KES.name", locale: :sw)
      KOP = I18n.t("num2words.currencies.KES.fractional.name", locale: :sw)
    end

    register :sw, SW
  end
end
