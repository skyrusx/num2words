# frozen_string_literal: true

module Num2words
  module Locales
    module KN
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :kn)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :kn)
      TEENS = I18n.t("num2words.teens", locale: :kn)
      TENS = I18n.t("num2words.tens", locale: :kn)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :kn)
      SCALES = I18n.t("num2words.scales", locale: :kn)

      FRACTIONS = I18n.t("num2words.fractions", locale: :kn)
      GRAMMAR = I18n.t("num2words.grammar", locale: :kn)

      DATE = I18n.t("num2words.date", locale: :kn)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :kn)
      TIME = I18n.t("num2words.time", locale: :kn)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :kn)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :kn)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :kn)

      UNDER_HUNDRED = [
        "ಸೊನ್ನೆ", "ಒಂದು", "ಎರಡು", "ಮೂರು", "ನಾಲ್ಕು", "ಐದು", "ಆರು", "ಏಳು", "ಎಂಟು", "ಒಂಬತ್ತು",
        "ಹತ್ತು", "ಹನ್ನೊಂದು", "ಹನ್ನೆರಡು", "ಹದಿಮೂರು", "ಹದಿನಾಲ್ಕು", "ಹದಿನೈದು", "ಹದಿನಾರು", "ಹದಿನೇಳು", "ಹದಿನೆಂಟು", "ಹತ್ತೊಂಬತ್ತು",
        "ಇಪ್ಪತ್ತು", "ಇಪ್ಪತ್ತೊಂದು", "ಇಪ್ಪತ್ತೆರಡು", "ಇಪ್ಪತ್ತಮೂರು", "ಇಪ್ಪತ್ತನಾಲ್ಕು", "ಇಪ್ಪತ್ತೈದು", "ಇಪ್ಪತ್ತಾರು", "ಇಪ್ಪತ್ತೇಳು", "ಇಪ್ಪತ್ತೆಂಟು", "ಇಪ್ಪತ್ತೊಂಬತ್ತು",
        "ಮೂವತ್ತು", "ಮೂವತ್ತೊಂದು", "ಮೂವತ್ತೆರಡು", "ಮೂವತ್ತಮೂರು", "ಮೂವತ್ತನಾಲ್ಕು", "ಮೂವತ್ತೈದು", "ಮೂವತ್ತಾರು", "ಮೂವತ್ತೇಳು", "ಮೂವತ್ತೆಂಟು", "ಮೂವತ್ತೊಂಬತ್ತು",
        "ನಲವತ್ತು", "ನಲವತ್ತೊಂದು", "ನಲವತ್ತೆರಡು", "ನಲವತ್ತಮೂರು", "ನಲವತ್ತನಾಲ್ಕು", "ನಲವತ್ತೈದು", "ನಲವತ್ತಾರು", "ನಲವತ್ತೇಳು", "ನಲವತ್ತೆಂಟು", "ನಲವತ್ತೊಂಬತ್ತು",
        "ಐವತ್ತು", "ಐವತ್ತೊಂದು", "ಐವತ್ತೆರಡು", "ಐವತ್ತಮೂರು", "ಐವತ್ತನಾಲ್ಕು", "ಐವತ್ತೈದು", "ಐವತ್ತಾರು", "ಐವತ್ತೇಳು", "ಐವತ್ತೆಂಟು", "ಐವತ್ತೊಂಬತ್ತು",
        "ಅರವತ್ತು", "ಅರವತ್ತೊಂದು", "ಅರವತ್ತೆರಡು", "ಅರವತ್ತಮೂರು", "ಅರವತ್ತನಾಲ್ಕು", "ಅರವತ್ತೈದು", "ಅರವತ್ತಾರು", "ಅರವತ್ತೇಳು", "ಅರವತ್ತೆಂಟು", "ಅರವತ್ತೊಂಬತ್ತು",
        "ಎಪ್ಪತ್ತು", "ಎಪ್ಪತ್ತೊಂದು", "ಎಪ್ಪತ್ತೆರಡು", "ಎಪ್ಪತ್ತಮೂರು", "ಎಪ್ಪತ್ತನಾಲ್ಕು", "ಎಪ್ಪತ್ತೈದು", "ಎಪ್ಪತ್ತಾರು", "ಎಪ್ಪತ್ತೇಳು", "ಎಪ್ಪತ್ತೆಂಟು", "ಎಪ್ಪತ್ತೊಂಬತ್ತು",
        "ಎಂಬತ್ತು", "ಎಂಬತ್ತೊಂದು", "ಎಂಬತ್ತೆರಡು", "ಎಂಬತ್ತಮೂರು", "ಎಂಬತ್ತನಾಲ್ಕು", "ಎಂಬತ್ತೈದು", "ಎಂಬತ್ತಾರು", "ಎಂಬತ್ತೇಳು", "ಎಂಬತ್ತೆಂಟು", "ಎಂಬತ್ತೊಂಬತ್ತು",
        "ತೊಂಬತ್ತು", "ತೊಂಬತ್ತೊಂದು", "ತೊಂಬತ್ತೆರಡು", "ತೊಂಬತ್ತಮೂರು", "ತೊಂಬತ್ತನಾಲ್ಕು", "ತೊಂಬತ್ತೈದು", "ತೊಂಬತ್ತಾರು", "ತೊಂಬತ್ತೇಳು", "ತೊಂಬತ್ತೆಂಟು", "ತೊಂಬತ್ತೊಂಬತ್ತು"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "ಅರಬ್"],
        [10_000_000, "ಕೋಟಿ"],
        [100_000, "ಲಕ್ಷ"],
        [1_000, "ಸಾವಿರ"]
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
        joiner.to_sym == :and ? "ಮತ್ತು" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "ದಶಮಾಂಶ"
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

    register :kn, KN
  end
end
