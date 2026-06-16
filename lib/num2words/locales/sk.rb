# frozen_string_literal: true

module Num2words
  module Locales
    module SK
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sk)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sk)
      TEENS = I18n.t("num2words.teens", locale: :sk)
      TENS = I18n.t("num2words.tens", locale: :sk)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sk)
      SCALES = I18n.t("num2words.scales", locale: :sk)

      FRACTIONS = I18n.t("num2words.fractions", locale: :sk)
      GRAMMAR = I18n.t("num2words.grammar", locale: :sk)

      DATE = I18n.t("num2words.date", locale: :sk)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :sk)
      TIME = I18n.t("num2words.time", locale: :sk)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :sk)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :sk)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :sk)

      module_function

      def fraction_numerator_feminine?
        true
      end

      def feminine_group?(scale_idx)
        scale_idx == 3
      end

      def currency_major_feminine?(currency)
        %i[CZK GBP UAH SEK NOK DKK INR IDR PKR TRY].include?(currency)
      end

      def currency_minor_feminine?(currency)
        %i[BGN BYN RUB UAH].include?(currency)
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "a" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def decimal_separator_word
        "čiarka"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

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

        return (feminine ? ONES_FEM[0] : ONES_MASC[0]) if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(3).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          next if group_value.zero?

          scale_idx = groups.size - index - 1
          group_words = triple_to_words(group_value, scale_idx, feminine: feminine_group?(scale_idx) || (feminine && scale_idx.zero?))
          group_words.shift if scale_idx == 1 && group_value == 1
          words.concat(group_words)
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

    register :sk, SK
  end
end
