# frozen_string_literal: true

module Num2words
  module Locales
    module SV
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sv)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sv)
      TEENS = I18n.t("num2words.teens", locale: :sv)
      TENS = I18n.t("num2words.tens", locale: :sv)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sv)
      SCALES = I18n.t("num2words.scales", locale: :sv)

      RUB = I18n.t("num2words.currencies.SEK.name", locale: :sv)
      KOP = I18n.t("num2words.currencies.SEK.fractional.name", locale: :sv)
    end

    register :sv, SV
  end
end
