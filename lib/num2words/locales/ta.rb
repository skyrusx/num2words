# frozen_string_literal: true

module Num2words
  module Locales
    module TA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ta)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ta)
      TEENS = I18n.t("num2words.teens", locale: :ta)
      TENS = I18n.t("num2words.tens", locale: :ta)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ta)
      SCALES = I18n.t("num2words.scales", locale: :ta)

      MAJOR_UNIT = I18n.t("num2words.currencies.INR.name", locale: :ta)
      MINOR_UNIT = I18n.t("num2words.currencies.INR.fractional.name", locale: :ta)
    end

    register :ta, TA
  end
end
