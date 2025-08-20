# frozen_string_literal: true

module Num2words
  module Locales
    module TE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :te)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :te)
      TEENS = I18n.t("num2words.teens", locale: :te)
      TENS = I18n.t("num2words.tens", locale: :te)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :te)
      SCALES = I18n.t("num2words.scales", locale: :te)

      MAJOR_UNIT = I18n.t("num2words.currencies.INR.name", locale: :te)
      MINOR_UNIT = I18n.t("num2words.currencies.INR.fractional.name", locale: :te)
    end

    register :te, TE
  end
end
