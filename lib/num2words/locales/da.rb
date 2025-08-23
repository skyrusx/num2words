# frozen_string_literal: true

module Num2words
  module Locales
    module DA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :da)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :da)
      TEENS = I18n.t("num2words.teens", locale: :da)
      TENS = I18n.t("num2words.tens", locale: :da)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :da)
      SCALES = I18n.t("num2words.scales", locale: :da)

      FRACTIONS = I18n.t("num2words.fractions", locale: :da)
      GRAMMAR = I18n.t("num2words.grammar", locale: :da)

      DATE = I18n.t("num2words.date", locale: :da)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :da)
      TIME = I18n.t("num2words.time", locale: :da)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :da)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :da)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :da)
    end

    register :da, DA
  end
end
