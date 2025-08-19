# frozen_string_literal: true

module Num2words
  module Locales
    module PT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :pt)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :pt)
      TEENS = I18n.t("num2words.teens", locale: :pt)
      TENS = I18n.t("num2words.tens", locale: :pt)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :pt)
      SCALES = I18n.t("num2words.scales", locale: :pt)

      RUB = I18n.t("num2words.currencies.EUR.name", locale: :pt)
      KOP = I18n.t("num2words.currencies.EUR.fractional.name", locale: :pt)
    end

    register :pt, PT
  end
end
