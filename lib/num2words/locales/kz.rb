# frozen_string_literal: true

module Num2words
  module Locales
    module KZ
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :kz)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :kz)
      TEENS = I18n.t("num2words.teens", locale: :kz)
      TENS = I18n.t("num2words.tens", locale: :kz)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :kz)
      SCALES = I18n.t("num2words.scales", locale: :kz)

      MAJOR_UNIT = I18n.t("num2words.currencies.KZT.name", locale: :kz)
      MINOR_UNIT = I18n.t("num2words.currencies.KZT.fractional.name", locale: :kz)
    end

    register :kz, KZ
  end
end
