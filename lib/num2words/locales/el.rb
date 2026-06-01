# frozen_string_literal: true

module Num2words
  module Locales
    module EL
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :el)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :el)
      TEENS = I18n.t("num2words.teens", locale: :el)
      TENS = I18n.t("num2words.tens", locale: :el)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :el)
      SCALES = I18n.t("num2words.scales", locale: :el)

      FRACTIONS = I18n.t("num2words.fractions", locale: :el)
      GRAMMAR = I18n.t("num2words.grammar", locale: :el)

      DATE = I18n.t("num2words.date", locale: :el)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :el)
      TIME = I18n.t("num2words.time", locale: :el)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :el)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :el)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :el)

      ONES_NEUT = ["μηδέν", "ένα", "δύο", "τρία", "τέσσερα", "πέντε", "έξι", "επτά", "οκτώ", "εννέα"].freeze
      TEENS_MASC = ["δέκα", "έντεκα", "δώδεκα", "δεκατρείς", "δεκατέσσερις", "δεκαπέντε", "δεκαέξι", "δεκαεπτά", "δεκαοκτώ", "δεκαεννέα"].freeze
      TEENS_FEM = TEENS_MASC
      TEENS_NEUT = TEENS
      FEMININE_MAJOR_CURRENCIES = %i[GBP TRY UAH CZK SEK NOK DKK INR IDR PKR].freeze
      NEUTER_MAJOR_CURRENCIES = %i[EUR USD RUB KRW PLN RON BGN BYN KZT ILS HUF SAR THB VND IRR RSD MYR BDT KES BRL CNY JPY].freeze
      NEUTER_MINOR_CURRENCIES = %i[EUR USD GBP JPY CNY RUB KRW TRY PLN UAH CZK RON BGN BYN KZT SEK NOK DKK HUF THB VND IDR IRR MYR KES BRL].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, gender: feminine ? :feminine : :masculine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        gender = feminine ? :feminine : :masculine
        gender = :feminine if scale_idx == 1
        gender = :neuter if scale_idx > 1
        triple_words(number, scale_idx, gender: gender)
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "και" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def time_unit_feminine?(unit)
        unit == :hour
      end

      def currency_number_words(number, currency, unit:)
        gender = unit == :major ? currency_major_gender(currency) : currency_minor_gender(currency)
        cardinal(number, gender: gender)
      end

      def date_day(day, format:, date_case:)
        ordinal(day, :default)
      end

      def date_year(year, format:)
        cardinal(year, gender: :neuter)
      end

      def ordinal(value, format, gender: :masculine)
        ordinals = ORDINALS[format] || ORDINALS[:nominative]
        gender_data = ordinals[gender] || ordinals[:masculine]

        return gender_data[value - 1] if value.between?(1, gender_data.length)

        cardinal(value)
      end

      def cardinal(number, gender: :masculine)
        integer_value = Integer(number)
        negative = integer_value.negative?
        integer_value = integer_value.abs

        return ones(gender)[0] if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(3).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          next if group_value.zero?

          scale_idx = groups.size - index - 1
          group_gender = scale_idx.zero? ? gender : scale_gender(scale_idx)
          group_words = triple_words(group_value, scale_idx, gender: group_gender)
          group_words.shift if scale_idx == 1 && group_value == 1
          words.concat group_words
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def triple_words(number, scale_idx, gender:)
        return [] if number.zero?

        words = []
        words << HUNDREDS[number / 100] if number >= 100
        rest = number % 100

        if rest.between?(10, 19)
          words << teens(gender)[rest - 10]
        else
          words << TENS[rest / 10] if rest >= 20
          value = rest % 10
          words << ones(gender)[value] if value.positive?
        end

        words << pluralize(number, *SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      def scale_gender(scale_idx)
        scale_idx == 1 ? :feminine : :neuter
      end

      def ones(gender)
        case gender
        when :feminine then ONES_FEM
        when :neuter then ONES_NEUT
        else ONES_MASC
        end
      end

      def teens(gender)
        case gender
        when :feminine then TEENS_FEM
        when :neuter then TEENS_NEUT
        else TEENS_MASC
        end
      end

      def currency_major_gender(currency)
        return :feminine if FEMININE_MAJOR_CURRENCIES.include?(currency)
        return :neuter if NEUTER_MAJOR_CURRENCIES.include?(currency)

        :masculine
      end

      def currency_minor_gender(currency)
        NEUTER_MINOR_CURRENCIES.include?(currency) ? :neuter : :feminine
      end

      def pluralize(number, singular, few, plural)
        number.abs == 1 ? singular : few
      end
    end

    register :el, EL
  end
end
