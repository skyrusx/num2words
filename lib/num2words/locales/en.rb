# frozen_string_literal: true

module Num2words
  module Locales
    module EN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :en)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :en)
      TEENS = I18n.t("num2words.teens", locale: :en)
      TENS = I18n.t("num2words.tens", locale: :en)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :en)
      SCALES = I18n.t("num2words.scales", locale: :en)

      MAJOR_UNIT = I18n.t("num2words.currencies.USD.name", locale: :en)
      MINOR_UNIT = I18n.t("num2words.currencies.USD.fractional.name", locale: :en)

      FRACTIONS = I18n.t("num2words.fractions", locale: :en)
      GRAMMAR = I18n.t("num2words.grammar", locale: :en)

      DATE = I18n.t("num2words.date", locale: :en)
      TEMPLATE = I18n.t("num2words.date.template", locale: :en)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :en)
    end

    register :en, EN
  end
end
