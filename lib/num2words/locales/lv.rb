# frozen_string_literal: true

module Num2words
  module Locales
    module LV
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :lv)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :lv)
      TEENS = I18n.t("num2words.teens", locale: :lv)
      TENS = I18n.t("num2words.tens", locale: :lv)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :lv)
      SCALES = I18n.t("num2words.scales", locale: :lv)

      FRACTIONS = I18n.t("num2words.fractions", locale: :lv)
      GRAMMAR = I18n.t("num2words.grammar", locale: :lv)

      DATE = I18n.t("num2words.date", locale: :lv)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :lv)
      TIME = I18n.t("num2words.time", locale: :lv)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :lv)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :lv)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :lv)

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = [under_thousand(number, feminine: feminine)]
        words << scale_form(number, scale_idx) unless scale_idx.zero?
        words
      end

      def feminine_group?(_scale_idx)
        false
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "un" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        true
      end

      def decimal_separator_word
        "komats"
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

      def time_unit_feminine?(_unit)
        true
      end

      def time_number_words(number, unit:)
        cardinal(number, feminine: true)
      end

      def currency_major_feminine?(currency)
        %i[BDT BGN CNY CZK DKK GBP IDR INR JPY KZT NOK PKR RON RSD SEK TRY UAH].include?(currency)
      end

      def currency_minor_feminine?(currency)
        %i[BDT BGN BRL BYN DKK ILS NOK RSD RUB SAR SEK TRY UAH].include?(currency)
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

      def scale_form(number, scale_idx)
        singular, plural, = SCALES[scale_idx]
        number.abs % 10 == 1 && number.abs % 100 != 11 ? singular : plural
      end

      def pluralize(number, singular, few, plural)
        number = number.abs
        return singular if number % 10 == 1 && number % 100 != 11
        return plural if number.zero? || (number % 10).zero? || (10..20).include?(number % 100)

        few
      end
    end

    register :lv, LV
  end
end
