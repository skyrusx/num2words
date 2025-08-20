# frozen_string_literal: true

module Num2words
  module Locales
    module MR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :mr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :mr)
      TEENS = I18n.t("num2words.teens", locale: :mr)
      TENS = I18n.t("num2words.tens", locale: :mr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :mr)
      SCALES = I18n.t("num2words.scales", locale: :mr)

      MAJOR_UNIT = I18n.t("num2words.currencies.INR.name", locale: :mr)
      MINOR_UNIT = I18n.t("num2words.currencies.INR.fractional.name", locale: :mr)
    end

    register :mr, MR
  end
end
