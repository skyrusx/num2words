# frozen_string_literal: true

module Num2words
  module Locales
    module FA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :fa)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :fa)
      TEENS = I18n.t("num2words.teens", locale: :fa)
      TENS = I18n.t("num2words.tens", locale: :fa)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :fa)
      SCALES = I18n.t("num2words.scales", locale: :fa)

      FRACTIONS = I18n.t("num2words.fractions", locale: :fa)
      GRAMMAR = I18n.t("num2words.grammar", locale: :fa)

      DATE = I18n.t("num2words.date", locale: :fa)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :fa)
      TIME = I18n.t("num2words.time", locale: :fa)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :fa)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :fa)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :fa)
    end

    register :fa, FA
  end
end
