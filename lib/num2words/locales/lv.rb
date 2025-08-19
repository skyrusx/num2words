# frozen_string_literal: true

module Num2words
  module Locales
    module LV
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :lv)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :lv)
      TEENS = I18n.t("num2words.teens", locale: :lv)
      TENS = I18n.t("num2words.tens", locale: :lv)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :lv)
      SCALES = I18n.t("num2words.scales", locale: :lv)

      RUB = I18n.t("num2words.currencies.EUR.name", locale: :lv)
      KOP = I18n.t("num2words.currencies.EUR.fractional.name", locale: :lv)
    end

    register :lv, LV
  end
end
