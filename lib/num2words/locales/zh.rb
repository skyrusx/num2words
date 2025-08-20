# frozen_string_literal: true

module Num2words
  module Locales
    module ZH
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :zh)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :zh)
      TEENS = I18n.t("num2words.teens", locale: :zh)
      TENS = I18n.t("num2words.tens", locale: :zh)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :zh)
      SCALES = I18n.t("num2words.scales", locale: :zh)

      MAJOR_UNIT = I18n.t("num2words.currencies.CNY.name", locale: :zh)
      MINOR_UNIT = I18n.t("num2words.currencies.CNY.fractional.name", locale: :zh)
    end

    register :zh, ZH
  end
end
