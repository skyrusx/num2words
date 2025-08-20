# frozen_string_literal: true

module Num2words
  module Locales
    module DE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :de)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :de)
      TEENS = I18n.t("num2words.teens", locale: :de)
      TENS = I18n.t("num2words.tens", locale: :de)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :de)
      SCALES = I18n.t("num2words.scales", locale: :de)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :de)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :de)
    end

    register :de, DE
  end
end
