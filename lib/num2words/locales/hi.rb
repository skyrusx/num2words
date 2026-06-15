# frozen_string_literal: true

module Num2words
  module Locales
    module HI
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :hi)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :hi)
      TEENS = I18n.t("num2words.teens", locale: :hi)
      TENS = I18n.t("num2words.tens", locale: :hi)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :hi)
      SCALES = I18n.t("num2words.scales", locale: :hi)

      FRACTIONS = I18n.t("num2words.fractions", locale: :hi)
      GRAMMAR = I18n.t("num2words.grammar", locale: :hi)

      DATE = I18n.t("num2words.date", locale: :hi)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :hi)
      TIME = I18n.t("num2words.time", locale: :hi)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :hi)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :hi)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :hi)

      UNDER_HUNDRED = [
        "शून्य", "एक", "दो", "तीन", "चार", "पाँच", "छह", "सात", "आठ", "नौ",
        "दस", "ग्यारह", "बारह", "तेरह", "चौदह", "पंद्रह", "सोलह", "सत्रह", "अठारह", "उन्नीस",
        "बीस", "इक्कीस", "बाईस", "तेईस", "चौबीस", "पच्चीस", "छब्बीस", "सत्ताईस", "अट्ठाईस", "उनतीस",
        "तीस", "इकतीस", "बत्तीस", "तैंतीस", "चौंतीस", "पैंतीस", "छत्तीस", "सैंतीस", "अड़तीस", "उनतालीस",
        "चालीस", "इकतालीस", "बयालीस", "तैंतालीस", "चवालीस", "पैंतालीस", "छियालीस", "सैंतालीस", "अड़तालीस", "उनचास",
        "पचास", "इक्यावन", "बावन", "तिरेपन", "चौवन", "पचपन", "छप्पन", "सत्तावन", "अट्ठावन", "उनसठ",
        "साठ", "इकसठ", "बासठ", "तिरेसठ", "चौंसठ", "पैंसठ", "छियासठ", "सड़सठ", "अड़सठ", "उनहत्तर",
        "सत्तर", "इकहत्तर", "बहत्तर", "तिहत्तर", "चौहत्तर", "पचहत्तर", "छिहत्तर", "सतहत्तर", "अठहत्तर", "उनासी",
        "अस्सी", "इक्यासी", "बयासी", "तिरासी", "चौरासी", "पचासी", "छियासी", "सत्तासी", "अट्ठासी", "नवासी",
        "नब्बे", "इक्यानवे", "बानवे", "तिरानवे", "चौरानवे", "पचानवे", "छियानवे", "सत्तानवे", "अट्ठानवे", "निन्यानवे"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "अरब"],
        [10_000_000, "करोड़"],
        [100_000, "लाख"],
        [1_000, "हज़ार"]
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
        joiner.to_sym == :and ? "और" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "दशमलव"
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

    register :hi, HI
  end
end
