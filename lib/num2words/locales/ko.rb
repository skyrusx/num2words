# frozen_string_literal: true

module Num2words
  module Locales
    module KO
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ko)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ko)
      TEENS = I18n.t("num2words.teens", locale: :ko)
      TENS = I18n.t("num2words.tens", locale: :ko)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ko)
      SCALES = I18n.t("num2words.scales", locale: :ko)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ko)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ko)

      DATE = I18n.t("num2words.date", locale: :ko)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ko)
      TIME = I18n.t("num2words.time", locale: :ko)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ko)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ko)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ko)

      LARGE_SCALES = ["", "만", "억", "조", "경"].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = under_ten_thousand(number)
        scale = LARGE_SCALES[scale_idx].to_s
        ["#{words}#{scale}"]
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "와" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "점"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def join_fraction_words(words)
        sign_word, integer_words, conjunction_word, numerator_words, denominator_words = words
        [sign_word, integer_words, conjunction_word, denominator_words, numerator_words].compact.reject(&:empty?).join(" ")
      end

      def date_day(day, format:, date_case:)
        cardinal(day)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def time_unit_feminine?(_unit)
        false
      end

      def time_number_words(number, unit:)
        cardinal(number)
      end

      def join_time_words(number_words, unit_words)
        "#{number_words} #{unit_words}"
      end

      def currency_major_feminine?(_currency)
        false
      end

      def currency_minor_feminine?(_currency)
        false
      end

      def currency_number_words(number, _currency, unit:)
        cardinal(number)
      end

      def join_currency_parts(parts)
        parts.join(" ").strip
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
                              .chars.reverse.each_slice(4).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = groups.each_with_index.filter_map do |group_value, index|
          next if group_value.zero?

          scale_index = groups.size - index - 1
          scale = LARGE_SCALES.fetch(scale_index, "")
          group_words = under_ten_thousand(group_value)
          scale.empty? ? group_words : "#{group_words}#{scale}"
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def under_ten_thousand(number)
        thousands = number / 1000
        remainder = number % 1000
        hundreds = remainder / 100
        rest = remainder % 100

        [
          unit_with_scale(thousands, "천"),
          unit_with_scale(hundreds, "백"),
          under_hundred(rest)
        ].compact.reject(&:empty?).join
      end

      def under_hundred(number)
        return "" if number.zero?
        return TEENS[number - 10] if number.between?(10, 19)
        return ONES_MASC[number] if number < 10

        tens = number / 10
        ones = number % 10
        [TENS[tens], ones.positive? ? ONES_MASC[ones] : nil].compact.reject(&:empty?).join
      end

      def unit_with_scale(value, scale)
        return "" if value.zero?
        return scale if value == 1

        "#{ONES_MASC[value]}#{scale}"
      end

      def pluralize(_number, singular, _few, _plural)
        singular
      end
    end

    register :ko, KO
  end
end
