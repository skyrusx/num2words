# frozen_string_literal: true

module Num2words
  module Locales
    module JA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ja)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ja)
      TEENS = I18n.t("num2words.teens", locale: :ja)
      TENS = I18n.t("num2words.tens", locale: :ja)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ja)
      SCALES = I18n.t("num2words.scales", locale: :ja)

      MAJOR_UNIT = I18n.t("num2words.currencies.JPY.name", locale: :ja)
      MINOR_UNIT = I18n.t("num2words.currencies.JPY.fractional.name", locale: :ja)
    end

    register :ja, JA
  end
end
