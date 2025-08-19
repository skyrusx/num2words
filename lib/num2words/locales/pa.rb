# frozen_string_literal: true

module Num2words
  module Locales
    module PA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :pa)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :pa)
      TEENS = I18n.t("num2words.teens", locale: :pa)
      TENS = I18n.t("num2words.tens", locale: :pa)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :pa)
      SCALES = I18n.t("num2words.scales", locale: :pa)

      RUB = I18n.t("num2words.currencies.INR.name", locale: :pa)
      KOP = I18n.t("num2words.currencies.INR.fractional.name", locale: :pa)
    end

    register :pa, PA
  end
end
