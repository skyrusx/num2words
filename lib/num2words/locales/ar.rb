# frozen_string_literal: true

module Num2words
  module Locales
    module AR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ar)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ar)
      TEENS = I18n.t("num2words.teens", locale: :ar)
      TENS = I18n.t("num2words.tens", locale: :ar)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ar)
      SCALES = I18n.t("num2words.scales", locale: :ar)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ar)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ar)

      DATE = I18n.t("num2words.date", locale: :ar)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ar)
      TIME = I18n.t("num2words.time", locale: :ar)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ar)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ar)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ar)
    end

    register :ar, AR
  end
end
