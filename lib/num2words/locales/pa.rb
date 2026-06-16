# frozen_string_literal: true

module Num2words
  module Locales
    module PA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :pa)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :pa)
      TEENS = I18n.t("num2words.teens", locale: :pa)
      TENS = I18n.t("num2words.tens", locale: :pa)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :pa)
      SCALES = I18n.t("num2words.scales", locale: :pa)

      FRACTIONS = I18n.t("num2words.fractions", locale: :pa)
      GRAMMAR = I18n.t("num2words.grammar", locale: :pa)

      DATE = I18n.t("num2words.date", locale: :pa)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :pa)
      TIME = I18n.t("num2words.time", locale: :pa)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :pa)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :pa)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :pa)

      UNDER_HUNDRED = [
        "ਜ਼ੀਰੋ", "ਇੱਕ", "ਦੋ", "ਤਿੰਨ", "ਚਾਰ", "ਪੰਜ", "ਛੇ", "ਸੱਤ", "ਅੱਠ", "ਨੌਂ",
        "ਦਸ", "ਗਿਆਰਾਂ", "ਬਾਰਾਂ", "ਤੇਰਾਂ", "ਚੌਦਾਂ", "ਪੰਦਰਾਂ", "ਸੋਲ੍ਹਾਂ", "ਸਤਾਰਾਂ", "ਅਠਾਰਾਂ", "ਉੱਨੀ",
        "ਵੀਹ", "ਇੱਕੀ", "ਬਾਈ", "ਤੇਈ", "ਚੌਵੀ", "ਪੱਚੀ", "ਛੱਬੀ", "ਸਤਾਈ", "ਅਠਾਈ", "ਉਨੱਤੀ",
        "ਤੀਹ", "ਇਕੱਤੀ", "ਬੱਤੀ", "ਤੇਤੀ", "ਚੌਂਤੀ", "ਪੈਂਤੀ", "ਛੱਤੀ", "ਸੈਂਤੀ", "ਅਠੱਤੀ", "ਉਨਤਾਲੀ",
        "ਚਾਲੀ", "ਇਕਤਾਲੀ", "ਬਿਆਲੀ", "ਤਿਰਤਾਲੀ", "ਚੁਤਾਲੀ", "ਪੰਤਾਲੀ", "ਛਿਆਲੀ", "ਸੰਤਾਲੀ", "ਅਠਤਾਲੀ", "ਉਨੰਜਾ",
        "ਪੰਜਾਹ", "ਇਕਵੰਜਾ", "ਬਵੰਜਾ", "ਤਰਵੰਜਾ", "ਚੁਰੰਜਾ", "ਪਚਵੰਜਾ", "ਛਪੰਜਾ", "ਸਤਵੰਜਾ", "ਅਠਵੰਜਾ", "ਉਨਾਹਠ",
        "ਸੱਠ", "ਇਕਾਹਠ", "ਬਾਹਠ", "ਤਰੇਂਹਠ", "ਚੌਂਹਠ", "ਪੈਂਹਠ", "ਛਿਆਹਠ", "ਸਤਾਹਠ", "ਅਠਾਹਠ", "ਉਨੱਤਰ",
        "ਸੱਤਰ", "ਇਕਹੱਤਰ", "ਬਹੱਤਰ", "ਤਿਹੱਤਰ", "ਚੌਹੱਤਰ", "ਪਚਹੱਤਰ", "ਛਿਹੱਤਰ", "ਸਤੱਤਰ", "ਅਠੱਤਰ", "ਉਨਾਸੀ",
        "ਅੱਸੀ", "ਇਕਿਆਸੀ", "ਬਿਆਸੀ", "ਤਿਰਾਸੀ", "ਚੌਰਾਸੀ", "ਪਚਾਸੀ", "ਛਿਆਸੀ", "ਸਤਾਸੀ", "ਅਠਾਸੀ", "ਨਵਾਸੀ",
        "ਨੱਬੇ", "ਇਕਾਨਵੇਂ", "ਬਾਨਵੇਂ", "ਤਰਾਨਵੇਂ", "ਚੁਰਾਨਵੇਂ", "ਪਚਾਨਵੇਂ", "ਛਿਆਨਵੇਂ", "ਸਤਾਨਵੇਂ", "ਅਠਾਨਵੇਂ", "ਨੜਿਨਵੇਂ"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "ਅਰਬ"],
        [10_000_000, "ਕਰੋੜ"],
        [100_000, "ਲੱਖ"],
        [1_000, "ਹਜ਼ਾਰ"]
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
        joiner.to_sym == :and ? "ਅਤੇ" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "ਦਸ਼ਮਲਵ"
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

    register :pa, PA
  end
end
