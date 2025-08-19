# frozen_string_literal: true

module Num2words
  module Locales
    module BG
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :bg)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :bg)
      TEENS = I18n.t("num2words.teens", locale: :bg)
      TENS = I18n.t("num2words.tens", locale: :bg)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :bg)
      SCALES = I18n.t("num2words.scales", locale: :bg)

      RUB = I18n.t("num2words.currencies.BGN.name", locale: :bg)
      KOP = I18n.t("num2words.currencies.BGN.fractional.name", locale: :bg)
    end

    register :bg, BG
  end
end
