# frozen_string_literal: true

module Num2words
  module Locales
    module HR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hr)
      TEENS = I18n.t("num2words.teens", locale: :hr)
      TENS = I18n.t("num2words.tens", locale: :hr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hr)
      SCALES = I18n.t("num2words.scales", locale: :hr)

      FRACTIONS = I18n.t("num2words.fractions", locale: :hr)
      GRAMMAR = I18n.t("num2words.grammar", locale: :hr)

      DATE = I18n.t("num2words.date", locale: :hr)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :hr)
      TIME = I18n.t("num2words.time", locale: :hr)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :hr)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :hr)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :hr)
    end

    register :hr, HR
  end
end
