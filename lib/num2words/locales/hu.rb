# frozen_string_literal: true

module Num2words
  module Locales
    module HU
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hu)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hu)
      TEENS = I18n.t("num2words.teens", locale: :hu)
      TENS = I18n.t("num2words.tens", locale: :hu)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hu)
      SCALES = I18n.t("num2words.scales", locale: :hu)

      RUB = I18n.t("num2words.currencies.HUF.name", locale: :hu)
      KOP = I18n.t("num2words.currencies.HUF.fractional.name", locale: :hu)
    end

    register :hu, HU
  end
end
