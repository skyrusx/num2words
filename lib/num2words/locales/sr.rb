# frozen_string_literal: true

module Num2words
  module Locales
    module SR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sr)
      TEENS = I18n.t("num2words.teens", locale: :sr)
      TENS = I18n.t("num2words.tens", locale: :sr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sr)
      SCALES = I18n.t("num2words.scales", locale: :sr)

      MAJOR_UNIT = I18n.t("num2words.currencies.RSD.name", locale: :sr)
      MINOR_UNIT = I18n.t("num2words.currencies.RSD.fractional.name", locale: :sr)
    end

    register :sr, Sr
  end
end
