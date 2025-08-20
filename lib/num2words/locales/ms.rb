# frozen_string_literal: true

module Num2words
  module Locales
    module MS
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ms)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ms)
      TEENS = I18n.t("num2words.teens", locale: :ms)
      TENS = I18n.t("num2words.tens", locale: :ms)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ms)
      SCALES = I18n.t("num2words.scales", locale: :ms)

      MAJOR_UNIT = I18n.t("num2words.currencies.MYR.name", locale: :ms)
      MINOR_UNIT = I18n.t("num2words.currencies.MYR.fractional.name", locale: :ms)
    end

    register :ms, MS
  end
end
