# frozen_string_literal: true

module Num2words
  module Locales
    module BE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :be)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :be)
      TEENS = I18n.t("num2words.teens", locale: :be)
      TENS = I18n.t("num2words.tens", locale: :be)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :be)
      SCALES = I18n.t("num2words.scales", locale: :be)

      FRACTIONS = I18n.t("num2words.fractions", locale: :be)
      GRAMMAR = I18n.t("num2words.grammar", locale: :be)

      DATE = I18n.t("num2words.date", locale: :be)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :be)
      TIME = I18n.t("num2words.time", locale: :be)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :be)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :be)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :be)

      module_function

      def feminine_group?(scale_idx)
        scale_idx == 1
      end

      def fraction_numerator_feminine?
        true
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "і" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def triple_to_words(number, scale_idx, feminine: false)
        words = []

        words << HUNDREDS[number / 100] if number >= 100
        rest = number % 100

        if rest.between?(10, 19)
          words << TEENS[rest - 10]
        else
          words << TENS[rest / 10] if rest >= 20
          ones = rest % 10
          words << (feminine ? ONES_FEM[ones] : ONES_MASC[ones]) if ones.positive?
        end

        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      def date_day(day, format:, date_case:)
        return ordinal(day, :default, gender: :masculine) if date_case.to_sym == :genitive

        ordinal(day, :nominative, gender: :neuter)
      end

      def date_year(year, format:)
        ordinal(year, :default)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        if value > 31
          thousands = (value / 100) * 100
          last_two = value % 100
          base_year = cardinal(thousands)
          last_ordinal = gender_data[last_two - 1] || cardinal(last_two)

          return [base_year, last_ordinal].join(" ")
        end

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
          scale_idx = groups.size - index - 1
          group_feminine = feminine_group?(scale_idx) || feminine
          words.concat triple_to_words(group_value, scale_idx, feminine: group_feminine)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def pluralize(number, singular, few, plural)
        number = number.abs
        return plural if (11..14).include?(number % 100)

        case number % 10
        when 1 then singular
        when 2..4 then few
        else plural
        end
      end
    end

    register :be, BE
  end
end
