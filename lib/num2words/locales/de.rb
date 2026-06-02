# frozen_string_literal: true

module Num2words
  module Locales
    module DE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :de)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :de)
      TEENS = I18n.t("num2words.teens", locale: :de)
      TENS = I18n.t("num2words.tens", locale: :de)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :de)
      SCALES = I18n.t("num2words.scales", locale: :de)

      FRACTIONS = I18n.t("num2words.fractions", locale: :de)
      GRAMMAR = I18n.t("num2words.grammar", locale: :de)

      DATE = I18n.t("num2words.date", locale: :de)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :de)
      TIME = I18n.t("num2words.time", locale: :de)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :de)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :de)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :de)

      module_function

      def feminine_group?(scale_idx)
        scale_idx >= 2
      end

      def fraction_numerator_feminine?
        false
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "und" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def currency_major_feminine?(currency)
        %i[UAH CZK SEK NOK DKK INR IDR PKR].include?(currency)
      end

      def currency_minor_feminine?(currency)
        false
      end

      def currency_number_words(number, currency, unit:)
        return cardinal(number, feminine: currency_major_feminine?(currency)) unless Integer(number) == 1

        unit == :major && currency_major_feminine?(currency) ? "eine" : "ein"
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
        cardinal(year).delete(" ")
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
        hundred_words = hundreds == 1 ? "einhundert" : "#{under_hundred(hundreds)}hundert"

        return hundred_words if rest.zero?

        "#{hundred_words}#{under_hundred(rest, feminine: feminine)}"
      end

      def under_hundred(number, feminine: false)
        return feminine ? ONES_FEM[number] : ONES_MASC[number] if number < 10
        return TEENS[number - 10] if number < 20
        return TENS[number / 10] if (number % 10).zero?

        ones = number % 10
        tens = number / 10
        ones_word = ones == 1 ? "ein" : ONES_MASC[ones]

        "#{ones_word}und#{TENS[tens]}"
      end

      def pluralize(number, singular, few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :de, DE
  end
end
