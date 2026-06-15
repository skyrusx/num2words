# frozen_string_literal: true

module Num2words
  module Locales
    module GU
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :gu)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :gu)
      TEENS = I18n.t("num2words.teens", locale: :gu)
      TENS = I18n.t("num2words.tens", locale: :gu)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :gu)
      SCALES = I18n.t("num2words.scales", locale: :gu)

      FRACTIONS = I18n.t("num2words.fractions", locale: :gu)
      GRAMMAR = I18n.t("num2words.grammar", locale: :gu)

      DATE = I18n.t("num2words.date", locale: :gu)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :gu)
      TIME = I18n.t("num2words.time", locale: :gu)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :gu)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :gu)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :gu)

      UNDER_HUNDRED = [
        "શૂન્ય", "એક", "બે", "ત્રણ", "ચાર", "પાંચ", "છ", "સાત", "આઠ", "નવ",
        "દસ", "અગિયાર", "બાર", "તેર", "ચૌદ", "પંદર", "સોળ", "સત્તર", "અઢાર", "ઓગણીસ",
        "વીસ", "એકવીસ", "બાવીસ", "ત્રેવીસ", "ચોવીસ", "પચ્ચીસ", "છવીસ", "સત્તાવીસ", "અઠ્ઠાવીસ", "ઓગણત્રીસ",
        "ત્રીસ", "એકત્રીસ", "બત્રીસ", "તેત્રીસ", "ચોત્રીસ", "પાંત્રીસ", "છત્રીસ", "સાડત્રીસ", "આડત્રીસ", "ઓગણચાલીસ",
        "ચાલીસ", "એકતાલીસ", "બેતાલીસ", "ત્રેતાલીસ", "ચુમ્માલીસ", "પિસ્તાલીસ", "છેતાલીસ", "સુડતાલીસ", "અડતાલીસ", "ઓગણપચાસ",
        "પચાસ", "એકાવન", "બાવન", "ત્રેપન", "ચોપન", "પંચાવન", "છપ્પન", "સત્તાવન", "અઠ્ઠાવન", "ઓગણસાઠ",
        "સાઠ", "એકસઠ", "બાસઠ", "ત્રેસઠ", "ચોસઠ", "પાંસઠ", "છાસઠ", "સડસઠ", "અડસઠ", "ઓગણસિત્તેર",
        "સિત્તેર", "એકોતેર", "બોતેર", "તોતેર", "ચુમોતેર", "પંચોતેર", "છોતેર", "સિત્યોતેર", "અઠ્યોતેર", "ઓગણએંસી",
        "એંસી", "એક્યાસી", "બ્યાસી", "ત્ર્યાસી", "ચોર્યાસી", "પંચ્યાસી", "છ્યાસી", "સિત્યાસી", "ઈઠ્યાસી", "નેવ્યાસી",
        "નેવું", "એકાણું", "બાણું", "ત્રાણું", "ચોરાણું", "પંચાણું", "છન્નું", "સત્તાણું", "અઠ્ઠાણું", "નવ્વાણું"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "અબજ"],
        [10_000_000, "કરોડ"],
        [100_000, "લાખ"],
        [1_000, "હજાર"]
      ].freeze

      module_function

      def integer_to_words(number, feminine: false)
        cardinal(number)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        return [] if number.zero?

        words = [under_thousand(number)]
        words << SCALES[scale_idx][0] unless scale_idx.zero?
        words
      end

      def minus_word
        GRAMMAR[:minus]
      end

      def fraction_joiner(_joiner)
        GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "દશાંશ"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| cardinal(digit.to_i) }.join(" ")
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

        cardinal(value)
      end

      def cardinal(number)
        integer_value = Integer(number)
        negative = integer_value.negative?
        integer_value = integer_value.abs

        return UNDER_HUNDRED[0] if integer_value.zero?

        remainder = integer_value
        words = []

        INDIAN_SCALES.each do |value, label|
          next if remainder < value

          group_value = remainder / value
          remainder %= value
          words << [cardinal(group_value), label].join(" ")
        end

        words << under_thousand(remainder) if remainder.positive?
        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def under_thousand(number)
        return UNDER_HUNDRED[number] if number < 100

        hundreds = number / 100
        rest = number % 100
        words = [HUNDREDS[hundreds]]
        words << UNDER_HUNDRED[rest] if rest.positive?
        words.join(" ")
      end

      def pluralize(number, singular, few, _plural)
        number.abs == 1 ? singular : few
      end
    end

    register :gu, GU
  end
end
