# frozen_string_literal: true

module Num2words
  module Locales
    module HE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :he)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :he)
      TEENS = I18n.t("num2words.teens", locale: :he)
      TENS = I18n.t("num2words.tens", locale: :he)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :he)
      SCALES = I18n.t("num2words.scales", locale: :he)

      FRACTIONS = I18n.t("num2words.fractions", locale: :he)
      GRAMMAR = I18n.t("num2words.grammar", locale: :he)

      DATE = I18n.t("num2words.date", locale: :he)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :he)
      TIME = I18n.t("num2words.time", locale: :he)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :he)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :he)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :he)

      FEMININE_MAJOR_CURRENCIES = %i[TRY UAH CZK SEK NOK DKK INR IDR PKR].freeze
      FEMININE_MINOR_CURRENCIES = %i[ILS RUB UAH BGN BYN SAR INR PKR RSD BDT].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = []
        scale_forms = SCALES[scale_idx]

        if scale_idx == 1
          return [scale_forms[0]] if number == 1
          return [scale_forms[1]] if number == 2
        elsif scale_idx.positive? && number == 1
          return [scale_forms[0]]
        end

        words << under_thousand(number, feminine: feminine)
        words << pluralize(number, *scale_forms) unless scale_idx.zero?
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "ו" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        true
      end

      def decimal_separator_word
        "נקודה"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def time_unit_feminine?(unit)
        unit == :hour || unit == :minute || unit == :second
      end

      def currency_major_feminine?(currency)
        FEMININE_MAJOR_CURRENCIES.include?(currency)
      end

      def currency_minor_feminine?(currency)
        FEMININE_MINOR_CURRENCIES.include?(currency)
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

      def cardinal(number, feminine: false)
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
          words.concat triple_to_words(group_value, scale_idx, feminine: feminine)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def under_thousand(number, feminine: false)
        return under_hundred(number, feminine: feminine) if number < 100

        hundreds = number / 100
        rest = number % 100
        words = [HUNDREDS[hundreds]]
        words << under_hundred(rest, feminine: feminine) if rest.positive?
        words.join(" ")
      end

      def under_hundred(number, feminine: false)
        ones_data = feminine ? ONES_FEM : ONES_MASC

        return ones_data[number] if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10
        words = [TENS[tens]]
        words << "ו#{ones_data[ones]}" if ones.positive?
        words.join(" ")
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :he, HE
  end
end
