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

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = []
        words << under_thousand(number) unless scale_idx == 1 && number == 1
        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(_joiner)
        GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "koma"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :default)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:default] || ORDINALS[:nominative]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        cardinal(value)
      end

      def cardinal(number)
        integer_value = Integer(number)
        negative = integer_value.negative?
        integer_value = integer_value.abs

        return ONES_MASC[0] if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(3).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          next if group_value.zero?

          scale_idx = groups.size - index - 1
          words.concat triple_to_words(group_value, scale_idx)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def under_thousand(number)
        return under_hundred(number) if number < 100

        hundreds = number / 100
        rest = number % 100
        words = [HUNDREDS[hundreds]]
        words << under_hundred(rest) if rest.positive?
        words.join(" ")
      end

      def under_hundred(number)
        return ONES_MASC[number] if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10
        words = [TENS[tens]]
        words << ONES_MASC[ones] if ones.positive?
        words.join(" ")
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :et, ET
  end
end
