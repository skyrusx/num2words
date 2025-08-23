# frozen_string_literal: true

module Num2words
  module Locales
    module ET
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :et)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :et)
      TEENS = I18n.t("num2words.teens", locale: :et)
      TENS = I18n.t("num2words.tens", locale: :et)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :et)
      SCALES = I18n.t("num2words.scales", locale: :et)

      FRACTIONS = I18n.t("num2words.fractions", locale: :et)
      GRAMMAR = I18n.t("num2words.grammar", locale: :et)

      DATE = I18n.t("num2words.date", locale: :et)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :et)
      TIME = I18n.t("num2words.time", locale: :et)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :et)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :et)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :et)
    end

    register :et, ET
  end
end
