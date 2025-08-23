# frozen_string_literal: true

module Num2words
  module Locales
    module ID
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :id)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :id)
      TEENS = I18n.t("num2words.teens", locale: :id)
      TENS = I18n.t("num2words.tens", locale: :id)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :id)
      SCALES = I18n.t("num2words.scales", locale: :id)

      FRACTIONS = I18n.t("num2words.fractions", locale: :id)
      GRAMMAR = I18n.t("num2words.grammar", locale: :id)

      DATE = I18n.t("num2words.date", locale: :id)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :id)
      TIME = I18n.t("num2words.time", locale: :id)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :id)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :id)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :id)
    end

    register :id, ID
  end
end
