# frozen_string_literal: true

module Num2words
  module Locales
    module ID
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :id)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :id)
      TEENS = I18n.t("num2words.teens", locale: :id)
      TENS = I18n.t("num2words.tens", locale: :id)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :id)
      SCALES = I18n.t("num2words.scales", locale: :id)

      MAJOR_UNIT = I18n.t("num2words.currencies.IDR.name", locale: :id)
      MINOR_UNIT = I18n.t("num2words.currencies.IDR.fractional.name", locale: :id)
    end

    register :id, ID
  end
end
