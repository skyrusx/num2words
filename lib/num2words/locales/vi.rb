# frozen_string_literal: true

module Num2words
  module Locales
    module VI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :vi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :vi)
      TEENS = I18n.t("num2words.teens", locale: :vi)
      TENS = I18n.t("num2words.tens", locale: :vi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :vi)
      SCALES = I18n.t("num2words.scales", locale: :vi)

      FRACTIONS = I18n.t("num2words.fractions", locale: :vi)
      GRAMMAR = I18n.t("num2words.grammar", locale: :vi)

      DATE = I18n.t("num2words.date", locale: :vi)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :vi)
      TIME = I18n.t("num2words.time", locale: :vi)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :vi)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :vi)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :vi)

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = [under_thousand(number)]
        words << SCALES[scale_idx][0] unless scale_idx.zero?
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "và" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "phẩy"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def date_day(day, format:, date_case:)
        cardinal(day)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def currency_number_words(number, currency, unit:)
        cardinal(number)
      end

      def time_number_words(number, unit:)
        cardinal(number)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:default] || ORDINALS[:nominative]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        cardinal(value)
      end

      def cardinal(number)
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
          full_group = words.any? && group_value < 100
          group_words = under_thousand(group_value, full: full_group)
          words << [group_words, SCALES[scale_idx][0]].reject(&:empty?).join(" ")
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def under_thousand(number, full: false)
        return ONES_MASC[number] if number < 10 && !full
        return under_hundred(number, after_hundreds: false) if number < 100 && !full

        hundreds = number / 100
        rest = number % 100
        words = []

        words << (hundreds.positive? ? HUNDREDS[hundreds] : "không trăm")
        words << under_hundred(rest, after_hundreds: true) if rest.positive?
        words.join(" ")
      end

      def under_hundred(number, after_hundreds:)
        return ["linh", ONES_MASC[number]].join(" ") if number < 10 && after_hundreds
        return ONES_MASC[number] if number < 10
        return "mười" if number == 10

        if number < 20
          ones = number % 10
          return "mười lăm" if ones == 5

          return ["mười", ONES_MASC[ones]].join(" ")
        end

        tens = number / 10
        ones = number % 10
        words = [TENS[tens]]

        words << case ones
                 when 0 then nil
                 when 1 then "mốt"
                 when 4 then "tư"
                 when 5 then "lăm"
                 else ONES_MASC[ones]
                 end

        words.compact.join(" ")
      end

      def pluralize(number, singular, _few, _plural)
        singular
      end
    end

    register :vi, VI
  end
end
