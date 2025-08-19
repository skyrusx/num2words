# frozen_string_literal: true

module Num2words
  module Locales
    module TH
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :th)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :th)
      TEENS = I18n.t("num2words.teens", locale: :th)
      TENS = I18n.t("num2words.tens", locale: :th)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :th)
      SCALES = I18n.t("num2words.scales", locale: :th)

      RUB = I18n.t("num2words.currencies.THB.name", locale: :th)
      KOP = I18n.t("num2words.currencies.THB.fractional.name", locale: :th)
    end

    register :th, TH
  end
end
