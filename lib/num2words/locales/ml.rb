# frozen_string_literal: true

module Num2words
  module Locales
    module ML
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ml)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ml)
      TEENS = I18n.t("num2words.teens", locale: :ml)
      TENS = I18n.t("num2words.tens", locale: :ml)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ml)
      SCALES = I18n.t("num2words.scales", locale: :ml)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ml)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ml)

      DATE = I18n.t("num2words.date", locale: :ml)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ml)
      TIME = I18n.t("num2words.time", locale: :ml)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ml)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ml)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ml)

      UNDER_HUNDRED = [
        "പൂജ്യം", "ഒന്ന്", "രണ്ട്", "മൂന്ന്", "നാല്", "അഞ്ച്", "ആറ്", "ഏഴ്", "എട്ട്", "ഒമ്പത്",
        "പത്ത്", "പതിനൊന്ന്", "പന്ത്രണ്ട്", "പതിമൂന്ന്", "പതിനാല്", "പതിനഞ്ച്", "പതിനാറ്", "പതിനേഴ്", "പതിനെട്ട്", "പത്തൊമ്പത്",
        "ഇരുപത്", "ഇരുപത്തൊന്ന്", "ഇരുപത്തിരണ്ട്", "ഇരുപത്തിമൂന്ന്", "ഇരുപത്തിനാല്", "ഇരുപത്തിയഞ്ച്", "ഇരുപത്തിയാറ്", "ഇരുപത്തിയേഴ്", "ഇരുപത്തിയെട്ട്", "ഇരുപത്തൊമ്പത്",
        "മുപ്പത്", "മുപ്പത്തൊന്ന്", "മുപ്പത്തിരണ്ട്", "മുപ്പത്തിമൂന്ന്", "മുപ്പത്തിനാല്", "മുപ്പത്തിയഞ്ച്", "മുപ്പത്തിയാറ്", "മുപ്പത്തിയേഴ്", "മുപ്പത്തിയെട്ട്", "മുപ്പത്തൊമ്പത്",
        "നാല്പത്", "നാല്പത്തൊന്ന്", "നാല്പത്തിരണ്ട്", "നാല്പത്തിമൂന്ന്", "നാല്പത്തിനാല്", "നാല്പത്തിയഞ്ച്", "നാല്പത്തിയാറ്", "നാല്പത്തിയേഴ്", "നാല്പത്തിയെട്ട്", "നാല്പത്തൊമ്പത്",
        "അമ്പത്", "അമ്പത്തൊന്ന്", "അമ്പത്തിരണ്ട്", "അമ്പത്തിമൂന്ന്", "അമ്പത്തിനാല്", "അമ്പത്തിയഞ്ച്", "അമ്പത്തിയാറ്", "അമ്പത്തിയേഴ്", "അമ്പത്തിയെട്ട്", "അമ്പത്തൊമ്പത്",
        "അറുപത്", "അറുപത്തൊന്ന്", "അറുപത്തിരണ്ട്", "അറുപത്തിമൂന്ന്", "അറുപത്തിനാല്", "അറുപത്തിയഞ്ച്", "അറുപത്തിയാറ്", "അറുപത്തിയേഴ്", "അറുപത്തിയെട്ട്", "അറുപത്തൊമ്പത്",
        "എഴുപത്", "എഴുപത്തൊന്ന്", "എഴുപത്തിരണ്ട്", "എഴുപത്തിമൂന്ന്", "എഴുപത്തിനാല്", "എഴുപത്തിയഞ്ച്", "എഴുപത്തിയാറ്", "എഴുപത്തിയേഴ്", "എഴുപത്തിയെട്ട്", "എഴുപത്തൊമ്പത്",
        "എൺപത്", "എൺപത്തൊന്ന്", "എൺപത്തിരണ്ട്", "എൺപത്തിമൂന്ന്", "എൺപത്തിനാല്", "എൺപത്തിയഞ്ച്", "എൺപത്തിയാറ്", "എൺപത്തിയേഴ്", "എൺപത്തിയെട്ട്", "എൺപത്തൊമ്പത്",
        "തൊണ്ണൂറ്", "തൊണ്ണൂറ്റൊന്ന്", "തൊണ്ണൂറ്റിരണ്ട്", "തൊണ്ണൂറ്റിമൂന്ന്", "തൊണ്ണൂറ്റിനാല്", "തൊണ്ണൂറ്റിയഞ്ച്", "തൊണ്ണൂറ്റിയാറ്", "തൊണ്ണൂറ്റിയേഴ്", "തൊണ്ണൂറ്റിയെട്ട്", "തൊണ്ണൂറ്റൊമ്പത്"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "ശതകോടി"],
        [10_000_000, "കോടി"],
        [100_000, "ലക്ഷം"],
        [1_000, "ആയിരം"]
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

      def fraction_joiner(joiner)
        joiner.to_sym == :and ? "കൂടാതെ" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "ദശാംശം"
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

      def time_unit_feminine?(_unit)
        false
      end

      def time_number_words(number, unit:)
        cardinal(number)
      end

      def currency_major_feminine?(_currency)
        false
      end

      def currency_minor_feminine?(_currency)
        false
      end

      def currency_number_words(number, _currency, unit:)
        cardinal(number)
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

      def pluralize(_number, singular, _few, _plural)
        singular
      end
    end

    register :ml, ML
  end
end
