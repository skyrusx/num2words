# frozen_string_literal: true

module Num2words
  module Locales
    module HI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hi)
      TEENS = I18n.t("num2words.teens", locale: :hi)
      TENS = I18n.t("num2words.tens", locale: :hi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hi)
      SCALES = I18n.t("num2words.scales", locale: :hi)

      FRACTIONS = I18n.t("num2words.fractions", locale: :hi)
      GRAMMAR = I18n.t("num2words.grammar", locale: :hi)

      DATE = I18n.t("num2words.date", locale: :hi)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :hi)
      TIME = I18n.t("num2words.time", locale: :hi)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :hi)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :hi)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :hi)
    end

    register :hi, HI
  end
end
