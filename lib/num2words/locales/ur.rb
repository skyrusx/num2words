# frozen_string_literal: true

module Num2words
  module Locales
    module UR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ur)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ur)
      TEENS = I18n.t("num2words.teens", locale: :ur)
      TENS = I18n.t("num2words.tens", locale: :ur)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ur)
      SCALES = I18n.t("num2words.scales", locale: :ur)

      MAJOR_UNIT = I18n.t("num2words.currencies.PKR.name", locale: :ur)
      MINOR_UNIT = I18n.t("num2words.currencies.PKR.fractional.name", locale: :ur)
    end

    register :ur, UR
  end
end
