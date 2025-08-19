# frozen_string_literal: true

module Num2words
  module Locales
    module ML
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ml)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ml)
      TEENS = I18n.t("num2words.teens", locale: :ml)
      TENS = I18n.t("num2words.tens", locale: :ml)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ml)
      SCALES = I18n.t("num2words.scales", locale: :ml)

      RUB = I18n.t("num2words.currencies.INR.name", locale: :ml)
      KOP = I18n.t("num2words.currencies.INR.fractional.name", locale: :ml)
    end

    register :ml, ML
  end
end
