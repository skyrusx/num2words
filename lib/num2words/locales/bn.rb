# frozen_string_literal: true

module Num2words
  module Locales
    module BN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :bn)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :bn)
      TEENS = I18n.t("num2words.teens", locale: :bn)
      TENS = I18n.t("num2words.tens", locale: :bn)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :bn)
      SCALES = I18n.t("num2words.scales", locale: :bn)

      RUB = I18n.t("num2words.currencies.BDT.name", locale: :bn)
      KOP = I18n.t("num2words.currencies.BDT.fractional.name", locale: :bn)
    end

    register :bn, BN
  end
end
