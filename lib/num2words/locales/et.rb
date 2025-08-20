# frozen_string_literal: true

module Num2words
  module Locales
    module ET
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :et)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :et)
      TEENS = I18n.t("num2words.teens", locale: :et)
      TENS = I18n.t("num2words.tens", locale: :et)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :et)
      SCALES = I18n.t("num2words.scales", locale: :et)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :et)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :et)
    end

    register :et, ET
  end
end
