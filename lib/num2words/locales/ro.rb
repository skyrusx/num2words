# frozen_string_literal: true

module Num2words
  module Locales
    module RO
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ro)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ro)
      TEENS = I18n.t("num2words.teens", locale: :ro)
      TENS = I18n.t("num2words.tens", locale: :ro)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ro)
      SCALES = I18n.t("num2words.scales", locale: :ro)

      MAJOR_UNIT = I18n.t("num2words.currencies.RON.name", locale: :ro)
      MINOR_UNIT = I18n.t("num2words.currencies.RON.fractional.name", locale: :ro)
    end

    register :ro, RO
  end
end
