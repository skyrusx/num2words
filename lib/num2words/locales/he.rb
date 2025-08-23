# frozen_string_literal: true

module Num2words
  module Locales
    module HE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :he)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :he)
      TEENS = I18n.t("num2words.teens", locale: :he)
      TENS = I18n.t("num2words.tens", locale: :he)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :he)
      SCALES = I18n.t("num2words.scales", locale: :he)

      FRACTIONS = I18n.t("num2words.fractions", locale: :he)
      GRAMMAR = I18n.t("num2words.grammar", locale: :he)

      DATE = I18n.t("num2words.date", locale: :he)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :he)
      TIME = I18n.t("num2words.time", locale: :he)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :he)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :he)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :he)
    end

    register :he, HE
  end
end
