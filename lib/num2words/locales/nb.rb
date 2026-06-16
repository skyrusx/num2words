# frozen_string_literal: true

module Num2words
  module Locales
    module NB
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :nb)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :nb)
      TEENS = I18n.t("num2words.teens", locale: :nb)
      TENS = I18n.t("num2words.tens", locale: :nb)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :nb)
      SCALES = I18n.t("num2words.scales", locale: :nb)

      FRACTIONS = I18n.t("num2words.fractions", locale: :nb)
      GRAMMAR = I18n.t("num2words.grammar", locale: :nb)

      DATE = I18n.t("num2words.date", locale: :nb)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :nb)
      TIME = I18n.t("num2words.time", locale: :nb)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :nb)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :nb)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :nb)

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = triple_words(number, feminine: feminine)
        words[0] = "ett" if scale_idx == 1 && number == 1
        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "og" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        GRAMMAR[:conjunction]
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :nominative)
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

      def cardinal(number, feminine: false)
        integer_value = Integer(number)
        negative = integer_value.negative?
        integer_value = integer_value.abs

        return (feminine ? ONES_FEM[0] : ONES_MASC[0]) if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(3).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          next if group_value.zero?

          scale_idx = groups.size - index - 1
          group_words = triple_to_words(group_value, scale_idx, feminine: feminine && scale_idx.zero?)
          group_words.unshift("og") if scale_idx.zero? && words.any? && group_value < 100
          words.concat(group_words)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def triple_words(number, feminine: false)
        return [] if number.zero?

        hundreds = number / 100
        rest = number % 100
        words = []

        words << HUNDREDS[hundreds] if hundreds.positive?
        words << "og" if hundreds.positive? && rest.positive?
        words << under_hundred(rest, feminine: feminine) if rest.positive?
        words
      end

      def under_hundred(number, feminine: false)
        return TEENS[number - 10] if number.between?(10, 19)
        return TENS[number / 10] if number >= 20 && (number % 10).zero?
        return (feminine ? ONES_FEM[number] : ONES_MASC[number]) if number < 10

        "#{TENS[number / 10]}#{feminine ? ONES_FEM[number % 10] : ONES_MASC[number % 10]}"
      end

      def pluralize(number, singular, few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :nb, NB
  end
end
