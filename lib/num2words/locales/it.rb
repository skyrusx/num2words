# frozen_string_literal: true

module Num2words
  module Locales
    module IT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :it)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :it)
      TEENS = I18n.t("num2words.teens", locale: :it)
      TENS = I18n.t("num2words.tens", locale: :it)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :it)
      SCALES = I18n.t("num2words.scales", locale: :it)

      FRACTIONS = I18n.t("num2words.fractions", locale: :it)
      GRAMMAR = I18n.t("num2words.grammar", locale: :it)

      DATE = I18n.t("num2words.date", locale: :it)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :it)
      TIME = I18n.t("num2words.time", locale: :it)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :it)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :it)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :it)

      FEMININE_MAJOR_CURRENCIES = %i[GBP TRY UAH CZK SEK NOK DKK INR IDR PKR].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = []

        if scale_idx == 1
          return [SCALES[1][0]] if number == 1

          words << under_thousand(number, feminine: feminine)
          words << SCALES[1][1]
        elsif scale_idx.positive?
          words << (number == 1 ? "un" : under_thousand(number, feminine: feminine))
          words << pluralize(number, *SCALES[scale_idx])
        else
          words << under_thousand(number, feminine: feminine)
        end

        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "e" : GRAMMAR[:conjunction]
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

      def time_unit_feminine?(unit)
        unit == :hour
      end

      def currency_major_feminine?(currency)
        FEMININE_MAJOR_CURRENCIES.include?(currency)
      end

      def currency_minor_feminine?(_currency)
        false
      end

      def currency_number_words(number, currency, unit:)
        feminine = unit == :major ? currency_major_feminine?(currency) : currency_minor_feminine?(currency)

        cardinal(number, feminine: feminine)
      end

      def date_day(day, format:, date_case:)
        cardinal(day)
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
        hundred_word = HUNDREDS[hundreds]
        hundred_word = hundred_word[0...-1] if rest.between?(80, 89)

        return hundred_word if rest.zero?

        "#{hundred_word}#{under_hundred(rest, feminine: feminine)}"
      end

      def under_hundred(number, feminine: false)
        ones_data = feminine ? ONES_FEM : ONES_MASC

        return ones_data[number] if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10
        return TENS[tens] if ones.zero?

        tens_word = TENS[tens]
        tens_word = tens_word[0...-1] if [1, 8].include?(ones)
        "#{tens_word}#{ones_data[ones]}"
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :it, IT
  end
end
