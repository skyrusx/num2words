# frozen_string_literal: true

module Num2words
  module Locales
    module BG
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :bg)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :bg)
      TEENS = I18n.t("num2words.teens", locale: :bg)
      TENS = I18n.t("num2words.tens", locale: :bg)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :bg)
      SCALES = I18n.t("num2words.scales", locale: :bg)

      FRACTIONS = I18n.t("num2words.fractions", locale: :bg)
      GRAMMAR = I18n.t("num2words.grammar", locale: :bg)

      DATE = I18n.t("num2words.date", locale: :bg)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :bg)
      TIME = I18n.t("num2words.time", locale: :bg)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :bg)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :bg)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :bg)
    end

    register :bg, BG
  end
end
