# frozen_string_literal: true

module Num2words
  module Locales
    module FA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :fa)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :fa)
      TEENS = I18n.t("num2words.teens", locale: :fa)
      TENS = I18n.t("num2words.tens", locale: :fa)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :fa)
      SCALES = I18n.t("num2words.scales", locale: :fa)

      RUB = I18n.t("num2words.currencies.IRR.name", locale: :fa)
      KOP = I18n.t("num2words.currencies.IRR.fractional.name", locale: :fa)
    end

    register :fa, FA
  end
end
