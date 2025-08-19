# frozen_string_literal: true

module Num2words
  module Locales
    module HR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hr)
      TEENS = I18n.t("num2words.teens", locale: :hr)
      TENS = I18n.t("num2words.tens", locale: :hr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hr)
      SCALES = I18n.t("num2words.scales", locale: :hr)

      RUB = I18n.t("num2words.currencies.EUR.name", locale: :hr)
      KOP = I18n.t("num2words.currencies.EUR.fractional.name", locale: :hr)
    end

    register :hr, HR
  end
end
