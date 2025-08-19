# frozen_string_literal: true

module Num2words
  module Locales
    module KN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :kn)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :kn)
      TEENS = I18n.t("num2words.teens", locale: :kn)
      TENS = I18n.t("num2words.tens", locale: :kn)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :kn)
      SCALES = I18n.t("num2words.scales", locale: :kn)

      RUB = I18n.t("num2words.currencies.INR.name", locale: :kn)
      KOP = I18n.t("num2words.currencies.INR.fractional.name", locale: :kn)
    end

    register :kn, KN
  end
end
