# frozen_string_literal: true

module Num2words
  module Locales
    module JA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ja)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ja)
      TEENS = I18n.t("num2words.teens", locale: :ja)
      TENS = I18n.t("num2words.tens", locale: :ja)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ja)
      SCALES = I18n.t("num2words.scales", locale: :ja)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ja)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ja)

      DATE = I18n.t("num2words.date", locale: :ja)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ja)
      TIME = I18n.t("num2words.time", locale: :ja)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ja)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ja)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ja)
    end

    register :ja, JA
  end
end
