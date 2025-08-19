# frozen_string_literal: true

module Num2words
  module Locales
    module TR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :tr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :tr)
      TEENS = I18n.t("num2words.teens", locale: :tr)
      TENS = I18n.t("num2words.tens", locale: :tr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :tr)
      SCALES = I18n.t("num2words.scales", locale: :tr)

      RUB = I18n.t("num2words.currencies.TRY.name", locale: :tr)
      KOP = I18n.t("num2words.currencies.TRY.fractional.name", locale: :tr)
    end

    register :tr, TR
  end
end
