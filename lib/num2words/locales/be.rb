# frozen_string_literal: true

module Num2words
  module Locales
    module BE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :be)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :be)
      TEENS = I18n.t("num2words.teens", locale: :be)
      TENS = I18n.t("num2words.tens", locale: :be)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :be)
      SCALES = I18n.t("num2words.scales", locale: :be)

      MAJOR_UNIT = I18n.t("num2words.currencies.BYN.name", locale: :be)
      MINOR_UNIT = I18n.t("num2words.currencies.BYN.fractional.name", locale: :be)
    end

    register :be, BE
  end
end
