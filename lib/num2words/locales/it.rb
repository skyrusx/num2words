# frozen_string_literal: true

module Num2words
  module Locales
    module IT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :it)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :it)
      TEENS = I18n.t("num2words.teens", locale: :it)
      TENS = I18n.t("num2words.tens", locale: :it)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :it)
      SCALES = I18n.t("num2words.scales", locale: :it)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :it)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :it)
    end

    register :it, IT
  end
end
