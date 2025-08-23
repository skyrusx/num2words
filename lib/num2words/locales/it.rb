# frozen_string_literal: true

module Num2words
  module Locales
    module IT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :it)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :it)
      TEENS = I18n.t("num2words.teens", locale: :it)
      TENS = I18n.t("num2words.tens", locale: :it)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :it)
      SCALES = I18n.t("num2words.scales", locale: :it)

      FRACTIONS = I18n.t("num2words.fractions", locale: :it)
      GRAMMAR = I18n.t("num2words.grammar", locale: :it)

      DATE = I18n.t("num2words.date", locale: :it)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :it)
      TIME = I18n.t("num2words.time", locale: :it)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :it)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :it)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :it)
    end

    register :it, IT
  end
end
