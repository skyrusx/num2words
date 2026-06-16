# frozen_string_literal: true

module Num2words
  module Locales
    module RO
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ro)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ro)
      TEENS = I18n.t("num2words.teens", locale: :ro)
      TENS = I18n.t("num2words.tens", locale: :ro)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ro)
      SCALES = I18n.t("num2words.scales", locale: :ro)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ro)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ro)

      DATE = I18n.t("num2words.date", locale: :ro)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ro)
      TIME = I18n.t("num2words.time", locale: :ro)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ro)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ro)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ro)

      FEMININE_MAJOR_CURRENCIES = %i[GBP RUB TRY UAH CZK BYN SEK NOK DKK INR IDR PKR].freeze
      FEMININE_MINOR_CURRENCIES = %i[RUB UAH BYN ILS SAR].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, gender: feminine ? :feminine : :masculine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        return [under_thousand(number, gender: feminine ? :feminine : :masculine)] if scale_idx.zero?

        scale = pluralize(number, *SCALES[scale_idx])
        words = scale_number_words(number, scale_idx)
        words << "de" if needs_de_before_scale?(number)
        words << scale
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "și" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        true
      end

      def decimal_separator_word
        "virgulă"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def time_unit_feminine?(unit)
        %i[hour second].include?(unit)
      end

      def time_number_words(number, unit:)
        gender = time_unit_feminine?(unit) ? :feminine : :masculine
        cardinal(number, gender: gender)
      end

      def currency_major_feminine?(currency)
        FEMININE_MAJOR_CURRENCIES.include?(currency)
      end

      def currency_minor_feminine?(currency)
        FEMININE_MINOR_CURRENCIES.include?(currency)
      end

      def currency_number_words(number, currency, unit:)
        gender = if unit == :major
                   currency_major_feminine?(currency) ? :feminine : :masculine
                 else
                   currency_minor_feminine?(currency) ? :feminine : :masculine
                 end

        cardinal(number, gender: gender)
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :default)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:default] || ORDINALS[:nominative]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        cardinal(value, gender: gender)
      end

      def cardinal(number, gender: :masculine)
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
          words.concat triple_to_words(group_value, scale_idx, feminine: gender == :feminine && scale_idx.zero?)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def scale_number_words(number, scale_idx)
        return ["o"] if scale_idx == 1 && number == 1
        return ["un"] if scale_idx > 1 && number == 1
        return ["două"] if number == 2

        [under_thousand(number, gender: :masculine)]
      end

      def needs_de_before_scale?(number)
        number >= 20
      end

      def under_thousand(number, gender: :masculine)
        return under_hundred(number, gender: gender) if number < 100

        hundreds = number / 100
        rest = number % 100
        words = [HUNDREDS[hundreds]]
        words << under_hundred(rest, gender: gender) if rest.positive?
        words.join(" ")
      end

      def under_hundred(number, gender: :masculine)
        return one_word(number, gender: gender) if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10
        return TENS[tens] if ones.zero?

        [TENS[tens], one_word(ones, gender: gender)].join(" și ")
      end

      def one_word(number, gender:)
        return ONES_FEM[number] if gender == :feminine

        ONES_MASC[number]
      end

      def pluralize(number, singular, few, _plural)
        number.abs == 1 ? singular : few
      end
    end

    register :ro, RO
  end
end
