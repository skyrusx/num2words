# frozen_string_literal: true

module Num2words
  module Locales
    module FR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :fr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :fr)
      TEENS = I18n.t("num2words.teens", locale: :fr)
      TENS = I18n.t("num2words.tens", locale: :fr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :fr)
      SCALES = I18n.t("num2words.scales", locale: :fr)

      FRACTIONS = I18n.t("num2words.fractions", locale: :fr)
      GRAMMAR = I18n.t("num2words.grammar", locale: :fr)

      DATE = I18n.t("num2words.date", locale: :fr)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :fr)
      TIME = I18n.t("num2words.time", locale: :fr)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :fr)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :fr)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :fr)
    end

    register :fr, FR
  end
end
