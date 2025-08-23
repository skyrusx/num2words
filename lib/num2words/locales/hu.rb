# frozen_string_literal: true

module Num2words
  module Locales
    module HU
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hu)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hu)
      TEENS = I18n.t("num2words.teens", locale: :hu)
      TENS = I18n.t("num2words.tens", locale: :hu)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hu)
      SCALES = I18n.t("num2words.scales", locale: :hu)

      FRACTIONS = I18n.t("num2words.fractions", locale: :hu)
      GRAMMAR = I18n.t("num2words.grammar", locale: :hu)

      DATE = I18n.t("num2words.date", locale: :hu)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :hu)
      TIME = I18n.t("num2words.time", locale: :hu)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :hu)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :hu)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :hu)
    end

    register :hu, HU
  end
end
