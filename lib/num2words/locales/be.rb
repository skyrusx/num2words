# frozen_string_literal: true

module Num2words
  module Locales
    module BE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :be)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :be)
      TEENS = I18n.t("num2words.teens", locale: :be)
      TENS = I18n.t("num2words.tens", locale: :be)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :be)
      SCALES = I18n.t("num2words.scales", locale: :be)

      FRACTIONS = I18n.t("num2words.fractions", locale: :be)
      GRAMMAR = I18n.t("num2words.grammar", locale: :be)

      DATE = I18n.t("num2words.date", locale: :be)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :be)
      TIME = I18n.t("num2words.time", locale: :be)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :be)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :be)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :be)
    end

    register :be, BE
  end
end
