# frozen_string_literal: true

module Num2words
  module Locales
    module ZH
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :zh)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :zh)
      TEENS = I18n.t("num2words.teens", locale: :zh)
      TENS = I18n.t("num2words.tens", locale: :zh)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :zh)
      SCALES = I18n.t("num2words.scales", locale: :zh)

      FRACTIONS = I18n.t("num2words.fractions", locale: :zh)
      GRAMMAR = I18n.t("num2words.grammar", locale: :zh)

      DATE = I18n.t("num2words.date", locale: :zh)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :zh)
      TIME = I18n.t("num2words.time", locale: :zh)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :zh)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :zh)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :zh)

      LARGE_SCALES = ["", "万", "亿", "兆", "京"].freeze
      SMALL_UNITS = ["", "十", "百", "千"].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        ["#{under_ten_thousand(number)}#{LARGE_SCALES[scale_idx]}"]
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "又" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        GRAMMAR[:decimal_separator] || "点"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| ONES_MASC[digit.to_i] }.join
      end

      def join_decimal_words(words)
        words.compact.reject(&:empty?).join
      end

      def join_fraction_words(words)
        sign_word, integer_words, conjunction_word, numerator_words, denominator_words = words
        numerator_words = "" if denominator_words.to_s.end_with?(numerator_words.to_s)

        [sign_word, integer_words, conjunction_word, denominator_words, numerator_words].compact.reject(&:empty?).join
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
        "#{number_words}#{unit_words}"
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
        parts.join
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:default] || ORDINALS[:nominative]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        "第#{cardinal(value)}"
      end

      def cardinal(number)
        integer_value = Integer(number)
        negative = integer_value.negative?
        integer_value = integer_value.abs

        return ONES_MASC[0] if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(4).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        zero_between = false

        groups.each_with_index do |group_value, index|
          scale_idx = groups.size - index - 1

          if group_value.zero?
            zero_between = words.any?
            next
          end

          words << ONES_MASC[0] if words.any? && (zero_between || group_value < 1000) && words.last != ONES_MASC[0]
          words << "#{under_ten_thousand(group_value)}#{LARGE_SCALES.fetch(scale_idx, '')}"
          zero_between = false
        end

        words.unshift(minus_word) if negative
        words.join
      end

      def under_ten_thousand(number)
        digits = number.digits
        words = []
        zero_needed = false

        (3).downto(0) do |position|
          digit = digits[position].to_i

          if digit.zero?
            zero_needed = words.any? && lower_nonzero?(digits, position)
            next
          end

          words << ONES_MASC[0] if zero_needed
          words << unit_words(digit, position, words.empty?)
          zero_needed = false
        end

        words.join
      end

      def unit_words(digit, position, group_start)
        return ONES_MASC[digit] if position.zero?
        return SMALL_UNITS[position] if position == 1 && digit == 1 && group_start

        "#{ONES_MASC[digit]}#{SMALL_UNITS[position]}"
      end

      def lower_nonzero?(digits, position)
        (0...position).any? { |lower_position| digits[lower_position].to_i.positive? }
      end

      def pluralize(number, singular, few, _plural)
        number == 1 ? singular : few
      end
    end

    register :zh, ZH
  end
end
