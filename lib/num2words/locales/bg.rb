# frozen_string_literal: true

module Num2words
  module Locales
    module BG
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :bg)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :bg)
      TEENS = I18n.t("num2words.teens", locale: :bg)
      TENS = I18n.t("num2words.tens", locale: :bg)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :bg)
      SCALES = I18n.t("num2words.scales", locale: :bg)

      FRACTIONS = I18n.t("num2words.fractions", locale: :bg)
      GRAMMAR = I18n.t("num2words.grammar", locale: :bg)

      DATE = I18n.t("num2words.date", locale: :bg)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :bg)
      TIME = I18n.t("num2words.time", locale: :bg)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :bg)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :bg)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :bg)

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
        joiner.to_sym == :and ? "и" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        words = []

        hundreds = number / 100
        rest = number % 100

        words << HUNDREDS[hundreds] if hundreds.positive?

        if rest.between?(10, 19)
          words << join_with_conjunction(words, TEENS[rest - 10])
        else
          tens = rest / 10
          ones = rest % 10

          if tens >= 2
            tens_words = TENS[tens]
            words << (ones.positive? ? "#{tens_words} и #{feminine ? ONES_FEM[ones] : ONES_MASC[ones]}" : tens_words)
          elsif ones.positive?
            words << join_with_conjunction(words, feminine ? ONES_FEM[ones] : ONES_MASC[ones])
          end
        end

        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      def date_day(day, format:, date_case:)
        gender = date_case.to_sym == :genitive ? :masculine : :neuter
        ordinal(day, :nominative, gender: gender)
      end

      def date_year(year, format:)
        ordinal(year, :nominative)
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

        group_phrases = []
        groups.each_with_index do |group_value, index|
          next if group_value.zero?

          scale_idx = groups.size - index - 1
          group_feminine = feminine_group?(scale_idx) || feminine
          group_words = triple_to_words(group_value, scale_idx, feminine: group_feminine)
          group_words.shift if scale_idx == 1 && group_value == 1
          group_phrases << [group_words.join(" "), scale_idx, group_value]
        end

        result = join_groups(group_phrases)
        negative ? [minus_word, result].join(" ") : result
      end

      def pluralize(number, singular, few, plural)
        number.abs == 1 ? singular : few
      end

      def join_with_conjunction(words, value)
        words.empty? ? value : "и #{value}"
      end

      def join_groups(group_phrases)
        return "" if group_phrases.empty?

        phrases = group_phrases.map(&:first)
        last_scale_idx = group_phrases[-1][1]
        last_value = group_phrases[-1][2]

        if group_phrases.size > 1 && last_scale_idx.zero? && last_value < 100
          [phrases[0...-1].join(" "), phrases[-1]].join(" и ")
        else
          phrases.join(" ")
        end
      end
    end

    register :bg, BG
  end
end
