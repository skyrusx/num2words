# frozen_string_literal: true

module Num2words
  module Locales
    module CS
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :cs)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :cs)
      TEENS = I18n.t("num2words.teens", locale: :cs)
      TENS = I18n.t("num2words.tens", locale: :cs)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :cs)
      SCALES = I18n.t("num2words.scales", locale: :cs)

      RUB = I18n.t("num2words.currencies.CZK.name", locale: :cs)
      KOP = I18n.t("num2words.currencies.CZK.fractional.name", locale: :cs)
    end

    register :cs, CS
  end
end
