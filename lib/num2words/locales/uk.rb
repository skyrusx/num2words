# frozen_string_literal: true

module Num2words
  module Locales
    module UK
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :uk)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :uk)
      TEENS = I18n.t("num2words.teens", locale: :uk)
      TENS = I18n.t("num2words.tens", locale: :uk)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :uk)
      SCALES = I18n.t("num2words.scales", locale: :uk)

      RUB = I18n.t("num2words.currencies.UAH.name", locale: :uk)
      KOP = I18n.t("num2words.currencies.UAH.fractional.name", locale: :uk)
    end

    register :uk, UK
  end
end
