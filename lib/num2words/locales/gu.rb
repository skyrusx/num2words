# frozen_string_literal: true

module Num2words
  module Locales
    module GU
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :gu)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :gu)
      TEENS = I18n.t("num2words.teens", locale: :gu)
      TENS = I18n.t("num2words.tens", locale: :gu)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :gu)
      SCALES = I18n.t("num2words.scales", locale: :gu)

      FRACTIONS = I18n.t("num2words.fractions", locale: :gu)
      GRAMMAR = I18n.t("num2words.grammar", locale: :gu)

      DATE = I18n.t("num2words.date", locale: :gu)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :gu)
      TIME = I18n.t("num2words.time", locale: :gu)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :gu)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :gu)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :gu)
    end

    register :gu, GU
  end
end
