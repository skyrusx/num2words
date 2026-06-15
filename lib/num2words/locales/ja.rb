# frozen_string_literal: true

module Num2words
  module Locales
    module JA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ja)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ja)
      TEENS = I18n.t("num2words.teens", locale: :ja)
      TENS = I18n.t("num2words.tens", locale: :ja)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ja)
      SCALES = I18n.t("num2words.scales", locale: :ja)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ja)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ja)

      DATE = I18n.t("num2words.date", locale: :ja)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ja)
      TIME = I18n.t("num2words.time", locale: :ja)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ja)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ja)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ja)

      THOUSANDS = ["", "せん", "にせん", "さんぜん", "よんせん", "ごせん", "ろくせん", "ななせん", "はっせん", "きゅうせん"].freeze
      LARGE_SCALES = ["", "まん", "おく", "ちょう", "けい"].freeze

      class << self
        def integer_to_words(number, feminine: false)
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
            "#{under_ten_thousand(group_value)}#{LARGE_SCALES.fetch(scale_index, '')}"
          end.join

          negative ? "#{minus_word}#{words}" : words
        end

        def triple_to_words(number, scale_idx, feminine: false)
          words = under_ten_thousand(number)
          scale = LARGE_SCALES[scale_idx].to_s
          ["#{words}#{scale}"]
        end

        def minus_word
          GRAMMAR[:minus]
        end

        def fraction_joiner(joiner)
          joiner.to_sym == :and ? "と" : GRAMMAR[:conjunction]
        end

        def default_fraction_word
          GRAMMAR[:default_fraction]
        end

        def decimal_separator_word
          GRAMMAR[:decimal_separator] || "てん"
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

        def pluralize(number, singular, few, _plural)
          number == 1 ? singular : few
        end

        def currency_major_feminine?(_currency)
          false
        end

        def currency_minor_feminine?(_currency)
          false
        end

        def currency_number_words(number, _currency, unit:)
          integer_to_words(number)
        end

        def join_currency_parts(parts)
          parts.join
        end

        def time_unit_feminine?(_unit)
          false
        end

        def time_number_words(number, unit:)
          integer_to_words(number)
        end

        def join_time_words(number_words, unit_words)
          "#{number_words}#{unit_words}"
        end

        def date_day(day, format: :default, date_case: :default)
          integer_to_words(day)
        end

        def date_year(year, format: :default)
          integer_to_words(year)
        end

        def under_ten_thousand(number)
          thousands = number / 1000
          remainder = number % 1000
          hundreds = remainder / 100
          rest = remainder % 100

          [
            THOUSANDS[thousands],
            HUNDREDS[hundreds],
            under_hundred(rest)
          ].compact.reject(&:empty?).join
        end

        def under_hundred(number)
          return "" if number.zero?
          return TEENS[number - 10] if number.between?(10, 19)

          tens = number / 10
          ones = number % 10

          [TENS[tens], ones.positive? ? ONES_MASC[ones] : nil].compact.reject(&:empty?).join
        end
      end
    end

    register :ja, JA
  end
end
