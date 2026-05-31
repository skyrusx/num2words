# frozen_string_literal: true

module Num2words
  module Locales
    module CS
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :cs)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :cs)
      TEENS = I18n.t("num2words.teens", locale: :cs)
      TENS = I18n.t("num2words.tens", locale: :cs)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :cs)
      SCALES = I18n.t("num2words.scales", locale: :cs)

      FRACTIONS = I18n.t("num2words.fractions", locale: :cs)
      GRAMMAR = I18n.t("num2words.grammar", locale: :cs)

      DATE = I18n.t("num2words.date", locale: :cs)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :cs)
      TIME = I18n.t("num2words.time", locale: :cs)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :cs)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :cs)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :cs)

      module_function

      def fraction_numerator_feminine?
        true
      end

      def feminine_group?(scale_idx)
        scale_idx == 3
      end

      def currency_major_feminine?(currency)
        %i[CZK GBP UAH].include?(currency)
      end

      def currency_minor_feminine?(currency)
        false
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "a" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def integer_to_words(number, feminine: false)
        cardinal(number, feminine: feminine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

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
        ordinal(day, :default)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format]
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
          group_words = triple_to_words(group_value, scale_idx, feminine: feminine_group?(scale_idx) || (feminine && scale_idx.zero?))
          group_words.shift if scale_idx == 1 && group_value == 1
          words.concat group_words
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

    register :cs, CS
  end
end
