# frozen_string_literal: true

module Num2words
  module Locales
    module ES
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :es)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :es)
      TEENS = I18n.t("num2words.teens", locale: :es)
      TENS = I18n.t("num2words.tens", locale: :es)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :es)
      SCALES = I18n.t("num2words.scales", locale: :es)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :es)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :es)
    end

    register :es, ES
  end
end
