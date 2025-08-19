# frozen_string_literal: true

module Num2words
  module Locales
    module NO
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :no)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :no)
      TEENS = I18n.t("num2words.teens", locale: :no)
      TENS = I18n.t("num2words.tens", locale: :no)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :no)
      SCALES = I18n.t("num2words.scales", locale: :no)

      RUB = I18n.t("num2words.currencies.NOK.name", locale: :no)
      KOP = I18n.t("num2words.currencies.NOK.fractional.name", locale: :no)
    end

    register :no, NO
  end
end
