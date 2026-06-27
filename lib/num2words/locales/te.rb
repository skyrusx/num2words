# frozen_string_literal: true

module Num2words
  module Locales
    module TE
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :te)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :te)
      TEENS = I18n.t("num2words.teens", locale: :te)
      TENS = I18n.t("num2words.tens", locale: :te)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :te)
      SCALES = I18n.t("num2words.scales", locale: :te)

      FRACTIONS = I18n.t("num2words.fractions", locale: :te)
      GRAMMAR = I18n.t("num2words.grammar", locale: :te)

      DATE = I18n.t("num2words.date", locale: :te)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :te)
      TIME = I18n.t("num2words.time", locale: :te)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :te)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :te)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :te)

      UNDER_HUNDRED = [
        "సున్నా", "ఒకటి", "రెండు", "మూడు", "నాలుగు", "ఐదు", "ఆరు", "ఏడు", "ఎనిమిది", "తొమ్మిది",
        "పది", "పదకొండు", "పన్నెండు", "పదమూడు", "పద్నాలుగు", "పదిహేను", "పదహారు", "పదిహేడు", "పద్దెనిమిది", "పంతొమ్మిది",
        "ఇరవై", "ఇరవై ఒకటి", "ఇరవై రెండు", "ఇరవై మూడు", "ఇరవై నాలుగు", "ఇరవై ఐదు", "ఇరవై ఆరు", "ఇరవై ఏడు", "ఇరవై ఎనిమిది", "ఇరవై తొమ్మిది",
        "ముప్పై", "ముప్పై ఒకటి", "ముప్పై రెండు", "ముప్పై మూడు", "ముప్పై నాలుగు", "ముప్పై ఐదు", "ముప్పై ఆరు", "ముప్పై ఏడు", "ముప్పై ఎనిమిది", "ముప్పై తొమ్మిది",
        "నలభై", "నలభై ఒకటి", "నలభై రెండు", "నలభై మూడు", "నలభై నాలుగు", "నలభై ఐదు", "నలభై ఆరు", "నలభై ఏడు", "నలభై ఎనిమిది", "నలభై తొమ్మిది",
        "యాభై", "యాభై ఒకటి", "యాభై రెండు", "యాభై మూడు", "యాభై నాలుగు", "యాభై ఐదు", "యాభై ఆరు", "యాభై ఏడు", "యాభై ఎనిమిది", "యాభై తొమ్మిది",
        "అరవై", "అరవై ఒకటి", "అరవై రెండు", "అరవై మూడు", "అరవై నాలుగు", "అరవై ఐదు", "అరవై ఆరు", "అరవై ఏడు", "అరవై ఎనిమిది", "అరవై తొమ్మిది",
        "డెబ్బై", "డెబ్బై ఒకటి", "డెబ్బై రెండు", "డెబ్బై మూడు", "డెబ్బై నాలుగు", "డెబ్బై ఐదు", "డెబ్బై ఆరు", "డెబ్బై ఏడు", "డెబ్బై ఎనిమిది", "డెబ్బై తొమ్మిది",
        "ఎనభై", "ఎనభై ఒకటి", "ఎనభై రెండు", "ఎనభై మూడు", "ఎనభై నాలుగు", "ఎనభై ఐదు", "ఎనభై ఆరు", "ఎనభై ఏడు", "ఎనభై ఎనిమిది", "ఎనభై తొమ్మిది",
        "తొంభై", "తొంభై ఒకటి", "తొంభై రెండు", "తొంభై మూడు", "తొంభై నాలుగు", "తొంభై ఐదు", "తొంభై ఆరు", "తొంభై ఏడు", "తొంభై ఎనిమిది", "తొంభై తొమ్మిది"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "వంద కోట్లు"],
        [10_000_000, "కోటి"],
        [100_000, "లక్ష"],
        [1_000, "వెయ్యి"]
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
        joiner.to_sym == :and ? "మరియు" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "దశాంశం"
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

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :te, TE
  end
end
