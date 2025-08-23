# frozen_string_literal: true

module Num2words
  module Locales
    module EL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :el)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :el)
      TEENS = I18n.t("num2words.teens", locale: :el)
      TENS = I18n.t("num2words.tens", locale: :el)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :el)
      SCALES = I18n.t("num2words.scales", locale: :el)

      FRACTIONS = I18n.t("num2words.fractions", locale: :el)
      GRAMMAR = I18n.t("num2words.grammar", locale: :el)

      DATE = I18n.t("num2words.date", locale: :el)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :el)
      TIME = I18n.t("num2words.time", locale: :el)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :el)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :el)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :el)
    end

    register :el, EL
  end
end
