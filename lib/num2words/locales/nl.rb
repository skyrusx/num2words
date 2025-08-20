# frozen_string_literal: true

module Num2words
  module Locales
    module NL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :nl)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :nl)
      TEENS = I18n.t("num2words.teens", locale: :nl)
      TENS = I18n.t("num2words.tens", locale: :nl)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :nl)
      SCALES = I18n.t("num2words.scales", locale: :nl)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :nl)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :nl)
    end

    register :nl, NL
  end
end
