# frozen_string_literal: true

module Num2words
  module Locales
    module BN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :bn)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :bn)
      TEENS = I18n.t("num2words.teens", locale: :bn)
      TENS = I18n.t("num2words.tens", locale: :bn)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :bn)
      SCALES = I18n.t("num2words.scales", locale: :bn)

      FRACTIONS = I18n.t("num2words.fractions", locale: :bn)
      GRAMMAR = I18n.t("num2words.grammar", locale: :bn)

      DATE = I18n.t("num2words.date", locale: :bn)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :bn)
      TIME = I18n.t("num2words.time", locale: :bn)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :bn)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :bn)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :bn)
    end

    register :bn, BN
  end
end
