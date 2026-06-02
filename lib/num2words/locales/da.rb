# frozen_string_literal: true

module Num2words
  module Locales
    module DA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :da)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :da)
      TEENS = I18n.t("num2words.teens", locale: :da)
      TENS = I18n.t("num2words.tens", locale: :da)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :da)
      SCALES = I18n.t("num2words.scales", locale: :da)

      FRACTIONS = I18n.t("num2words.fractions", locale: :da)
      GRAMMAR = I18n.t("num2words.grammar", locale: :da)

      DATE = I18n.t("num2words.date", locale: :da)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :da)
      TIME = I18n.t("num2words.time", locale: :da)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :da)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :da)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :da)

      module_function

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

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :nominative)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        triple_words(number, feminine: feminine).tap do |words|
          words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        end
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:nominative]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        cardinal(value)
      end

      def pluralize(number, singular, few, plural)
        number.abs == 1 ? singular : plural
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
          group_words[0] = "et" if scale_idx == 1 && group_value == 1
          group_words.unshift("og") if scale_idx.zero? && words.any? && group_value < 100
          words.concat(group_words)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def triple_words(number, feminine: false)
        return [] if number.zero?

        words = []
        hundreds = number / 100
        rest = number % 100

        words << HUNDREDS[hundreds] if hundreds.positive?
        words << "og" if hundreds.positive? && rest.positive?
        words << under_hundred(rest, feminine: feminine) if rest.positive?
        words.compact
      end

      def under_hundred(number, feminine: false)
        return TEENS[number - 10] if number.between?(10, 19)
        return TENS[number / 10] if (number % 10).zero?
        return (feminine ? ONES_FEM[number] : ONES_MASC[number]) if number < 10

        ones = feminine ? ONES_FEM[number % 10] : ONES_MASC[number % 10]
        "#{ones}og#{TENS[number / 10]}"
      end
    end

    register :da, DA
  end
end
