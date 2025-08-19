# frozen_string_literal: true

module Num2words
  module Locales
    module PL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :pl)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :pl)
      TEENS = I18n.t("num2words.teens", locale: :pl)
      TENS = I18n.t("num2words.tens", locale: :pl)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :pl)
      SCALES = I18n.t("num2words.scales", locale: :pl)

      RUB = I18n.t("num2words.currencies.PLN.name", locale: :pl)
      KOP = I18n.t("num2words.currencies.PLN.fractional.name", locale: :pl)
    end

    register :pl, PL
  end
end
