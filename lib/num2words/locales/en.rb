# frozen_string_literal: true

module Num2words
  module Locales
    module EN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :en)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :en)
      TEENS = I18n.t("num2words.teens", locale: :en)
      TENS = I18n.t("num2words.tens", locale: :en)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :en)
      SCALES = I18n.t("num2words.scales", locale: :en)

      RUB = I18n.t("num2words.currencies.USD.name", locale: :en)
      KOP = I18n.t("num2words.currencies.USD.fractional.name", locale: :en)
    end

    register :en, EN
  end
end
