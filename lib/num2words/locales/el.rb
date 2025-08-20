# frozen_string_literal: true

module Num2words
  module Locales
    module EL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :el)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :el)
      TEENS = I18n.t("num2words.teens", locale: :el)
      TENS = I18n.t("num2words.tens", locale: :el)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :el)
      SCALES = I18n.t("num2words.scales", locale: :el)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :el)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :el)
    end

    register :el, EL
  end
end
