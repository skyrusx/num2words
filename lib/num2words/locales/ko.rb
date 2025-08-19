# frozen_string_literal: true

module Num2words
  module Locales
    module KO
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ko)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ko)
      TEENS = I18n.t("num2words.teens", locale: :ko)
      TENS = I18n.t("num2words.tens", locale: :ko)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ko)
      SCALES = I18n.t("num2words.scales", locale: :ko)

      RUB = I18n.t("num2words.currencies.KRW.name", locale: :ko)
      KOP = I18n.t("num2words.currencies.KRW.fractional.name", locale: :ko)
    end

    register :ko, KO
  end
end
