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

      MAJOR_UNIT = I18n.t("num2words.currencies.EUR.name", locale: :fr)
      MINOR_UNIT = I18n.t("num2words.currencies.EUR.fractional.name", locale: :fr)
    end

    register :fr, FR
  end
end
