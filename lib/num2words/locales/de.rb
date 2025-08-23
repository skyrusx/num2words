# frozen_string_literal: true

module Num2words
  module Locales
    module DE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :de)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :de)
      TEENS = I18n.t("num2words.teens", locale: :de)
      TENS = I18n.t("num2words.tens", locale: :de)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :de)
      SCALES = I18n.t("num2words.scales", locale: :de)

      FRACTIONS = I18n.t("num2words.fractions", locale: :de)
      GRAMMAR = I18n.t("num2words.grammar", locale: :de)

      DATE = I18n.t("num2words.date", locale: :de)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :de)
      TIME = I18n.t("num2words.time", locale: :de)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :de)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :de)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :de)
    end

    register :de, DE
  end
end
