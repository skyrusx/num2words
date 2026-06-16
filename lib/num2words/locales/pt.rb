# frozen_string_literal: true

module Num2words
  module Locales
    module PT
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :pt)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :pt)
      TEENS = I18n.t("num2words.teens", locale: :pt)
      TENS = I18n.t("num2words.tens", locale: :pt)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :pt)
      SCALES = I18n.t("num2words.scales", locale: :pt)

      FRACTIONS = I18n.t("num2words.fractions", locale: :pt)
      GRAMMAR = I18n.t("num2words.grammar", locale: :pt)

      DATE = I18n.t("num2words.date", locale: :pt)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :pt)
      TIME = I18n.t("num2words.time", locale: :pt)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :pt)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :pt)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :pt)

      HUNDREDS_FEM = ["", "cento", "duzentas", "trezentas", "quatrocentas", "quinhentas", "seiscentas", "setecentas", "oitocentas", "novecentas"].freeze
      FEMININE_MAJOR_CURRENCIES = %i[GBP TRY UAH CZK SEK NOK DKK INR IDR PKR BDT ILS].freeze
      FEMININE_MINOR_CURRENCIES = %i[ILS SAR].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, gender: feminine ? :feminine : :masculine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        gender = feminine ? :feminine : :masculine

        case scale_idx
        when 0
          [under_thousand(number, gender: gender)]
        when 1
          words = []
          words << under_thousand(number, gender: :masculine) unless number == 1
          words << SCALES[1][0]
          words
        else
          [under_thousand(number, gender: :masculine), pluralize(number, *SCALES[scale_idx])]
        end
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "e" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "vírgula"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def time_unit_feminine?(unit)
        unit == :hour
      end

      def time_number_words(number, unit:)
        cardinal(number, gender: unit == :hour ? :feminine : :masculine)
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
        day == 1 ? "primeiro" : cardinal(day)
      end

      def date_year(year, format:)
        cardinal(year)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:nominative]
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

      def under_thousand(number, gender: :masculine)
        return under_hundred(number, gender: gender) if number < 100
        return "cem" if number == 100

        hundreds = number / 100
        rest = number % 100
        words = [hundreds_data(gender)[hundreds]]
        words << under_hundred(rest, gender: gender) if rest.positive?
        words.join(" e ")
      end

      def under_hundred(number, gender: :masculine)
        return one_word(number, gender: gender) if number < 10
        return TEENS[number - 10] if number < 20

        tens = number / 10
        ones = number % 10
        return TENS[tens] if ones.zero?

        [TENS[tens], one_word(ones, gender: gender)].join(" e ")
      end

      def one_word(number, gender:)
        return ONES_FEM[number] if gender == :feminine

        ONES_MASC[number]
      end

      def hundreds_data(gender)
        gender == :feminine ? HUNDREDS_FEM : HUNDREDS
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :pt, PT
  end
end
