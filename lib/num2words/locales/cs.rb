# frozen_string_literal: true

module Num2words
  module Locales
    module CS
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :cs)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :cs)
      TEENS = I18n.t("num2words.teens", locale: :cs)
      TENS = I18n.t("num2words.tens", locale: :cs)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :cs)
      SCALES = I18n.t("num2words.scales", locale: :cs)

      FRACTIONS = I18n.t("num2words.fractions", locale: :cs)
      GRAMMAR = I18n.t("num2words.grammar", locale: :cs)

      DATE = I18n.t("num2words.date", locale: :cs)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :cs)
      TIME = I18n.t("num2words.time", locale: :cs)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :cs)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :cs)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :cs)
    end

    register :cs, CS
  end
end
