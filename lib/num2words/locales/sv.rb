# frozen_string_literal: true

module Num2words
  module Locales
    module SV
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sv)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sv)
      TEENS = I18n.t("num2words.teens", locale: :sv)
      TENS = I18n.t("num2words.tens", locale: :sv)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sv)
      SCALES = I18n.t("num2words.scales", locale: :sv)

      FRACTIONS = I18n.t("num2words.fractions", locale: :sv)
      GRAMMAR = I18n.t("num2words.grammar", locale: :sv)

      DATE = I18n.t("num2words.date", locale: :sv)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :sv)
      TIME = I18n.t("num2words.time", locale: :sv)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :sv)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :sv)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :sv)

      COMMON_GENDER_MAJOR_CURRENCIES = %i[
        BDT BGN BRL BYN CNY CZK DKK EUR HUF IDR ILS INR IRR JPY KES KRW
        KZT MYR NOK PKR PLN RON RSD RUB SAR SEK THB TRY UAH USD VND
      ].freeze

      module_function

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "och" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "komma"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def currency_major_feminine?(currency)
        COMMON_GENDER_MAJOR_CURRENCIES.include?(currency)
      end

      def currency_minor_feminine?(_currency)
        false
      end

      def currency_number_words(number, currency, unit:)
        feminine = unit == :major && currency_major_feminine?(currency)
        cardinal(number, feminine: feminine)
      end

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = []
        words << scale_number_words(number, scale_idx, feminine: feminine)
        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :nominative)
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
          words.concat(group_words)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def scale_number_words(number, scale_idx, feminine:)
        return "ett" if scale_idx == 1 && number == 1
        return "en" if scale_idx > 1 && number == 1

        under_thousand(number, feminine: feminine)
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
        return one_word(number, feminine: feminine) if number < 10
        return TEENS[number - 10] if number < 20
        return TENS[number / 10] if (number % 10).zero?

        "#{TENS[number / 10]}#{one_word(number % 10, feminine: feminine)}"
      end

      def one_word(number, feminine:)
        feminine ? ONES_FEM[number] : ONES_MASC[number]
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :sv, SV
  end
end
