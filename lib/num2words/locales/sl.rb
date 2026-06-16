# frozen_string_literal: true

module Num2words
  module Locales
    module SL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :sl)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :sl)
      TEENS = I18n.t("num2words.teens", locale: :sl)
      TENS = I18n.t("num2words.tens", locale: :sl)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :sl)
      SCALES = I18n.t("num2words.scales", locale: :sl)

      FRACTIONS = I18n.t("num2words.fractions", locale: :sl)
      GRAMMAR = I18n.t("num2words.grammar", locale: :sl)

      DATE = I18n.t("num2words.date", locale: :sl)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :sl)
      TIME = I18n.t("num2words.time", locale: :sl)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :sl)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :sl)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :sl)

      FEMININE_MAJOR_CURRENCIES = %i[CZK GBP RUB TRY UAH SEK NOK DKK BGN BYN INR IDR BDT PKR].freeze
      FEMININE_MINOR_CURRENCIES = %i[RUB UAH BGN BYN ILS SAR RSD BDT].freeze

      module_function

      def feminine_group?(scale_idx)
        scale_idx == 3
      end

      def fraction_numerator_feminine?
        true
      end

      def currency_major_feminine?(currency)
        FEMININE_MAJOR_CURRENCIES.include?(currency)
      end

      def currency_minor_feminine?(currency)
        FEMININE_MINOR_CURRENCIES.include?(currency)
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "in" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def decimal_separator_word
        "vejica"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def time_unit_feminine?(unit)
        %i[hour minute second].include?(unit)
      end

      def time_number_words(number, unit:)
        cardinal(number, feminine: time_unit_feminine?(unit))
      end

      def currency_number_words(number, currency, unit:)
        feminine = unit == :major ? currency_major_feminine?(currency) : currency_minor_feminine?(currency)
        cardinal(number, feminine: feminine)
      end

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = [under_thousand(number, feminine: feminine)]
        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words
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
          group_feminine = feminine_group?(scale_idx) || (feminine && scale_idx.zero?)
          group_words = triple_to_words(group_value, scale_idx, feminine: group_feminine)
          group_words.shift if scale_idx == 1 && group_value == 1
          words.concat(group_words)
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
        return one_word(number, feminine: feminine) if number < 10
        return TEENS[number - 10] if number < 20
        return TENS[number / 10] if (number % 10).zero?

        ones = number % 10
        tens = number / 10
        "#{compound_one(ones)}in#{TENS[tens]}"
      end

      def one_word(number, feminine:)
        feminine ? ONES_FEM[number] : ONES_MASC[number]
      end

      def compound_one(number)
        number == 1 ? "ena" : ONES_MASC[number]
      end

      def pluralize(number, singular, few, plural)
        number = number.abs
        return plural if (11..14).include?(number % 100)

        number == 1 ? singular : (number == 2 ? few : plural)
      end
    end

    register :sl, SL
  end
end
