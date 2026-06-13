# frozen_string_literal: true

module Num2words
  module Locales
    module ES
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :es)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :es)
      TEENS = I18n.t("num2words.teens", locale: :es)
      TENS = I18n.t("num2words.tens", locale: :es)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :es)
      SCALES = I18n.t("num2words.scales", locale: :es)

      FRACTIONS = I18n.t("num2words.fractions", locale: :es)
      GRAMMAR = I18n.t("num2words.grammar", locale: :es)

      DATE = I18n.t("num2words.date", locale: :es)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :es)
      TIME = I18n.t("num2words.time", locale: :es)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :es)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :es)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :es)

      HUNDREDS_FEM = ["", "cien", "doscientas", "trescientas", "cuatrocientas", "quinientas", "seiscientas", "setecientas", "ochocientas", "novecientas"].freeze
      VEINTI = {
        21 => { masculine: "veintiuno", feminine: "veintiuna", apocopated: "veintiún" },
        22 => "veintidós",
        23 => "veintitrés",
        24 => "veinticuatro",
        25 => "veinticinco",
        26 => "veintiséis",
        27 => "veintisiete",
        28 => "veintiocho",
        29 => "veintinueve"
      }.freeze
      FEMININE_MAJOR_CURRENCIES = %i[GBP TRY UAH CZK SEK NOK DKK INR IDR PKR].freeze
      FEMININE_MINOR_CURRENCIES = %i[BGN ILS SAR].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number, gender: feminine ? :feminine : :masculine)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        gender = feminine ? :feminine : :masculine
        words = []

        case scale_idx
        when 0
          words << under_thousand(number, gender: gender)
        when 1
          words << under_thousand(number, gender: :masculine, apocopate: true) unless number == 1
          words << SCALES[1][0]
        when 2, 4
          words << (number == 1 ? "un" : under_thousand(number, gender: :masculine, apocopate: true))
          words << pluralize(number, *SCALES[scale_idx])
        when 3
          words << under_thousand(number, gender: :masculine, apocopate: true) unless number == 1
          words << SCALES[3][0]
        else
          words << under_thousand(number, gender: :masculine, apocopate: true)
          words << pluralize(number, *SCALES[scale_idx])
        end

        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "y" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        true
      end

      def decimal_separator_word
        "coma"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
      end

      def time_unit_feminine?(unit)
        unit == :hour
      end

      def time_number_words(number, unit:)
        gender = unit == :hour ? :feminine : :masculine

        cardinal(number, gender: gender, apocopate: gender == :masculine)
      end

      def currency_number_words(number, currency, unit:)
        gender = if unit == :major
                   FEMININE_MAJOR_CURRENCIES.include?(currency) ? :feminine : :masculine
                 else
                   FEMININE_MINOR_CURRENCIES.include?(currency) ? :feminine : :masculine
                 end

        cardinal(number, gender: gender, apocopate: gender == :masculine)
      end

      def date_day(day, format:, date_case:)
        day == 1 ? "primero" : cardinal(day)
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

      def cardinal(number, gender: :masculine, apocopate: false)
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
          words.concat triple_to_words(group_value, scale_idx, feminine: gender == :feminine)
        end

        words.unshift(minus_word) if negative
        result = words.join(" ")
        apocopate ? apocopate_one(result) : result
      end

      def under_thousand(number, gender: :masculine, apocopate: false)
        return under_hundred(number, gender: gender, apocopate: apocopate) if number < 100
        return "cien" if number == 100

        hundreds = number / 100
        rest = number % 100
        hundreds_words = hundreds == 1 ? "ciento" : hundreds_data(gender)[hundreds]

        return hundreds_words if rest.zero?

        [hundreds_words, under_hundred(rest, gender: gender, apocopate: apocopate)].join(" ")
      end

      def under_hundred(number, gender: :masculine, apocopate: false)
        return one_word(number, gender: gender, apocopate: apocopate) if number < 10
        return TEENS[number - 10] if number < 20
        return TENS[2] if number == 20

        if number < 30
          value = VEINTI[number]
          return value unless value.is_a?(Hash)

          return value[:apocopated] if apocopate

          value[gender] || value[:masculine]
        else
          tens = number / 10
          ones = number % 10
          return TENS[tens] if ones.zero?

          [TENS[tens], one_word(ones, gender: gender, apocopate: apocopate)].join(" y ")
        end
      end

      def one_word(number, gender:, apocopate:)
        return "un" if number == 1 && apocopate
        return ONES_FEM[number] if gender == :feminine

        ONES_MASC[number]
      end

      def apocopate_one(words)
        words.sub(/veintiuno\z/, "veintiún").sub(/ y uno\z/, " y un").sub(/uno\z/, "un")
      end

      def hundreds_data(gender)
        gender == :feminine ? HUNDREDS_FEM : HUNDREDS
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :es, ES
  end
end
