# frozen_string_literal: true

module Num2words
  module Locales
    module AR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ar)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ar)
      TEENS = I18n.t("num2words.teens", locale: :ar)
      TENS = I18n.t("num2words.tens", locale: :ar)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ar)
      SCALES = I18n.t("num2words.scales", locale: :ar)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ar)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ar)

      DATE = I18n.t("num2words.date", locale: :ar)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ar)
      TIME = I18n.t("num2words.time", locale: :ar)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ar)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ar)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ar)

      module_function

      def integer_to_words(number, feminine: false)
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
          words << scale_group_to_words(group_value, scale_idx, feminine: feminine && scale_idx.zero?)
        end

        result = words.join(" و")
        negative ? [minus_word, result].join(" ") : result
      end

      def triple_to_words(number, scale_idx, feminine: false)
        scale_group_to_words(number, scale_idx, feminine: feminine).split
      end

      def scale_group_to_words(number, scale_idx, feminine: false)
        return under_thousand(number, feminine: feminine) if scale_idx.zero?

        scale_forms = SCALES[scale_idx]
        case number
        when 1
          scale_forms[0]
        when 2
          scale_forms[1]
        else
          scale_form = number.between?(3, 10) ? scale_forms[2] : scale_forms[0]
          [under_thousand(number), scale_form].join(" ")
        end
      end

      def under_thousand(number, feminine: false)
        hundreds = number / 100
        rest = number % 100

        return under_hundred(rest, feminine: feminine) if hundreds.zero?
        return HUNDREDS[hundreds] if rest.zero?

        [HUNDREDS[hundreds], under_hundred(rest, feminine: feminine)].join(" و")
      end

      def under_hundred(number, feminine: false)
        ones_data = feminine ? ONES_FEM : ONES_MASC

        return ones_data[number] if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10

        return TENS[tens] if ones.zero?

        [ones_data[ones], TENS[tens]].join(" و")
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "و" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def decimal_separator_word
        GRAMMAR[:conjunction]
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| integer_to_words(digit.to_i) }.join(" ")
      end

      def join_fraction_words(words)
        parts = words.reject(&:empty?)
        joiner_index = parts.index("و")

        if joiner_index && parts[joiner_index + 1]
          parts[joiner_index + 1] = "و#{parts[joiner_index + 1]}"
          parts.delete_at(joiner_index)
        end

        parts.join(" ")
      end

      def fraction_numerator_feminine?
        false
      end

      def date_day(day, format:, date_case:)
        ordinal(day, format)
      end

      def date_year(year, format:)
        integer_to_words(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:default]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        integer_to_words(value)
      end

      def pluralize(number, singular, dual, plural)
        number = number.abs
        return singular if number == 1
        return dual if number == 2
        return plural if number.zero? || number.between?(3, 10)

        singular
      end
    end

    register :ar, AR
  end
end
