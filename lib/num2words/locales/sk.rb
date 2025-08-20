# frozen_string_literal: true

module Num2words
  module Locales
    module SK
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sk)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sk)
      TEENS = I18n.t("num2words.teens", locale: :sk)
      TENS = I18n.t("num2words.tens", locale: :sk)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sk)
      SCALES = I18n.t("num2words.scales", locale: :sk)

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :sk)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :sk)
    end

    register :sk, SK
  end
end
