# frozen_string_literal: true

module Num2words
  module Locales
    module KZ
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :kz)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :kz)
      TEENS = I18n.t("num2words.teens", locale: :kz)
      TENS = I18n.t("num2words.tens", locale: :kz)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :kz)
      SCALES = I18n.t("num2words.scales", locale: :kz)

      FRACTIONS = I18n.t("num2words.fractions", locale: :kz)
      GRAMMAR = I18n.t("num2words.grammar", locale: :kz)

      DATE = I18n.t("num2words.date", locale: :kz)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :kz)
      TIME = I18n.t("num2words.time", locale: :kz)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :kz)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :kz)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :kz)

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = [under_thousand(number)]
        words << SCALES[scale_idx][0] unless scale_idx.zero?
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "және" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "үтір"
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

      def time_unit_feminine?(_unit)
        false
      end

      def time_number_words(number, unit:)
        cardinal(number)
      end

      def currency_major_feminine?(_currency)
        false
      end

      def currency_minor_feminine?(_currency)
        false
      end

      def currency_number_words(number, _currency, unit:)
        cardinal(number)
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

          scale_index = groups.size - index - 1
          words << under_thousand(group_value)
          words << SCALES[scale_index][0] unless scale_index.zero?
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def under_thousand(number)
        return ONES_MASC[number] if number < 10
        return TEENS[number - 10] if number.between?(10, 19)
        return under_hundred(number) if number < 100

        hundreds = number / 100
        rest = number % 100
        words = [HUNDREDS[hundreds]]
        words << under_hundred(rest) if rest.positive?
        words.join(" ")
      end

      def under_hundred(number)
        return "" if number.zero?
        return ONES_MASC[number] if number < 10
        return TEENS[number - 10] if number.between?(10, 19)

        tens = number / 10
        ones = number % 10
        words = [TENS[tens]]
        words << ONES_MASC[ones] if ones.positive?
        words.join(" ")
      end

      def pluralize(number, singular, few, _plural)
        number.abs == 1 ? singular : few
      end
    end

    register :kz, KZ
  end
end
