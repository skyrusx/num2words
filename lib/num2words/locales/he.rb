# frozen_string_literal: true

module Num2words
  module Locales
    module HE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :he)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :he)
      TEENS = I18n.t("num2words.teens", locale: :he)
      TENS = I18n.t("num2words.tens", locale: :he)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :he)
      SCALES = I18n.t("num2words.scales", locale: :he)

      MAJOR_UNIT = I18n.t("num2words.currencies.ILS.name", locale: :he)
      MINOR_UNIT = I18n.t("num2words.currencies.ILS.fractional.name", locale: :he)
    end

    register :he, HE
  end
end
