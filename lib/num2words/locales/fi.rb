# frozen_string_literal: true

module Num2words
  module Locales
    module FI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :fi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :fi)
      TEENS = I18n.t("num2words.teens", locale: :fi)
      TENS = I18n.t("num2words.tens", locale: :fi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :fi)
      SCALES = I18n.t("num2words.scales", locale: :fi)

      FRACTIONS = I18n.t("num2words.fractions", locale: :fi)
      GRAMMAR = I18n.t("num2words.grammar", locale: :fi)

      DATE = I18n.t("num2words.date", locale: :fi)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :fi)
      TIME = I18n.t("num2words.time", locale: :fi)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :fi)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :fi)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :fi)
    end

    register :fi, FI
  end
end
