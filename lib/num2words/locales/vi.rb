# frozen_string_literal: true

module Num2words
  module Locales
    module VI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :vi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :vi)
      TEENS = I18n.t("num2words.teens", locale: :vi)
      TENS = I18n.t("num2words.tens", locale: :vi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :vi)
      SCALES = I18n.t("num2words.scales", locale: :vi)

      RUB = I18n.t("num2words.currencies.VND.name", locale: :vi)
      KOP = I18n.t("num2words.currencies.VND.fractional.name", locale: :vi)
    end

    register :vi, VI
  end
end
