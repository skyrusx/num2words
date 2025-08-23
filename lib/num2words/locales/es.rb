# frozen_string_literal: true

module Num2words
  module Locales
    module ES
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :es)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :es)
      TEENS = I18n.t("num2words.teens", locale: :es)
      TENS = I18n.t("num2words.tens", locale: :es)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :es)
      SCALES = I18n.t("num2words.scales", locale: :es)

      FRACTIONS = I18n.t("num2words.fractions", locale: :es)
      GRAMMAR = I18n.t("num2words.grammar", locale: :es)

      DATE = I18n.t("num2words.date", locale: :es)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :es)
      TIME = I18n.t("num2words.time", locale: :es)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :es)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :es)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :es)
    end

    register :es, ES
  end
end
