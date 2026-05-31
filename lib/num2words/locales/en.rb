# frozen_string_literal: true

module Num2words
  module Locales
    module EN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :en)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :en)
      TEENS = I18n.t("num2words.teens", locale: :en)
      TENS = I18n.t("num2words.tens", locale: :en)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :en)
      SCALES = I18n.t("num2words.scales", locale: :en)

      FRACTIONS = I18n.t("num2words.fractions", locale: :en)
      GRAMMAR = I18n.t("num2words.grammar", locale: :en)

      DATE = I18n.t("num2words.date", locale: :en)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :en)
      TIME = I18n.t("num2words.time", locale: :en)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :en)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :en)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :en)

      module_function

      def feminine_group?(_scale_idx)
        false
      end

      def fraction_numerator_feminine?
        false
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

      def decimal_separator_word
        "point"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def triple_to_words(number, scale_idx, feminine: false)
        words = []

        words << HUNDREDS[number / 100] if number >= 100
        rest = number % 100

        if rest.between?(10, 19)
          words << TEENS[rest - 10]
        else
          words << TENS[rest / 10] if rest >= 20
          ones = rest % 10
          words << (feminine ? ONES_FEM[ones] : ONES_MASC[ones]) if ones.positive?
        end

        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      def date_day(day, format:, date_case:)
        ordinal(day, format)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format]
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
          scale_idx = groups.size - index - 1
          words.concat triple_to_words(group_value, scale_idx, feminine: feminine)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def pluralize(number, singular, few, plural)
        number = number.abs
        return plural if (11..14).include?(number % 100)

        case number % 10
        when 1 then singular
        when 2..4 then few
        else plural
        end
      end
    end

    register :en, EN
  end
end
