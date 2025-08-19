# frozen_string_literal: true

module Num2words
  module Locales
    module NB
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :nb)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :nb)
      TEENS = I18n.t("num2words.teens", locale: :nb)
      TENS = I18n.t("num2words.tens", locale: :nb)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :nb)
      SCALES = I18n.t("num2words.scales", locale: :nb)

      RUB = I18n.t("num2words.currencies.NOK.name", locale: :nb)
      KOP = I18n.t("num2words.currencies.NOK.fractional.name", locale: :nb)
    end

    register :nb, NB
  end
end
