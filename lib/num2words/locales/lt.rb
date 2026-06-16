# frozen_string_literal: true

module Num2words
  module Locales
    module LT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :lt)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :lt)
      TEENS = I18n.t("num2words.teens", locale: :lt)
      TENS = I18n.t("num2words.tens", locale: :lt)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :lt)
      SCALES = I18n.t("num2words.scales", locale: :lt)

      FRACTIONS = I18n.t("num2words.fractions", locale: :lt)
      GRAMMAR = I18n.t("num2words.grammar", locale: :lt)

      DATE = I18n.t("num2words.date", locale: :lt)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :lt)
      TIME = I18n.t("num2words.time", locale: :lt)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :lt)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :lt)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :lt)

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = [under_thousand(number, feminine: feminine)]
        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words
      end

      def feminine_group?(scale_idx)
        false
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "ir" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        true
      end

      def decimal_separator_word
        "kablelis"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :default, gender: :feminine)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def time_unit_feminine?(unit)
        %i[minute second].include?(unit)
      end

      def time_number_words(number, unit:)
        cardinal(number, feminine: time_unit_feminine?(unit))
      end

      def currency_major_feminine?(currency)
        %i[BGN BRL BYN CNY CZK DKK IDR INR JPY KZT NOK PKR RON RSD SEK TRY UAH].include?(currency)
      end

      def currency_minor_feminine?(currency)
        %i[BGN BRL BYN DKK IDR ILS INR NOK PKR RSD RUB SEK SAR TRY UAH].include?(currency)
      end

      def currency_number_words(number, currency, unit:)
        feminine = unit == :major ? currency_major_feminine?(currency) : currency_minor_feminine?(currency)
        cardinal(number, feminine: feminine)
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
          group_feminine = scale_idx.zero? && feminine
          words.concat triple_to_words(group_value, scale_idx, feminine: group_feminine)
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
        return (feminine ? ONES_FEM[number] : ONES_MASC[number]) if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10
        words = [TENS[tens]]
        words << (feminine ? ONES_FEM[ones] : ONES_MASC[ones]) if ones.positive?
        words.join(" ")
      end

      def pluralize(number, singular, few, plural)
        number = number.abs
        return plural if (10..20).include?(number % 100)

        case number % 10
        when 1 then singular
        when 2..9 then few
        else plural
        end
      end
    end

    register :lt, LT
  end
end
