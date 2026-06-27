# frozen_string_literal: true

module Num2words
  module Locales
    module TA
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :ta)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :ta)
      TEENS = I18n.t("num2words.teens", locale: :ta)
      TENS = I18n.t("num2words.tens", locale: :ta)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :ta)
      SCALES = I18n.t("num2words.scales", locale: :ta)

      FRACTIONS = I18n.t("num2words.fractions", locale: :ta)
      GRAMMAR = I18n.t("num2words.grammar", locale: :ta)

      DATE = I18n.t("num2words.date", locale: :ta)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :ta)
      TIME = I18n.t("num2words.time", locale: :ta)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :ta)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :ta)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :ta)

      UNDER_HUNDRED = [
        "பூஜ்ஜியம்", "ஒன்று", "இரண்டு", "மூன்று", "நான்கு", "ஐந்து", "ஆறு", "ஏழு", "எட்டு", "ஒன்பது",
        "பத்து", "பதினொன்று", "பன்னிரண்டு", "பதிமூன்று", "பதிநான்கு", "பதினைந்து", "பதினாறு", "பதினேழு", "பதினெட்டு", "பத்தொன்பது",
        "இருபது", "இருபத்தொன்று", "இருபத்திரண்டு", "இருபத்துமூன்று", "இருபத்துநான்கு", "இருபத்தைந்து", "இருபத்தாறு", "இருபத்தேழு", "இருபத்தெட்டு", "இருபத்தொன்பது",
        "முப்பது", "முப்பத்தொன்று", "முப்பத்திரண்டு", "முப்பத்துமூன்று", "முப்பத்துநான்கு", "முப்பத்தைந்து", "முப்பத்தாறு", "முப்பத்தேழு", "முப்பத்தெட்டு", "முப்பத்தொன்பது",
        "நாற்பது", "நாற்பத்தொன்று", "நாற்பத்திரண்டு", "நாற்பத்துமூன்று", "நாற்பத்துநான்கு", "நாற்பத்தைந்து", "நாற்பத்தாறு", "நாற்பத்தேழு", "நாற்பத்தெட்டு", "நாற்பத்தொன்பது",
        "ஐம்பது", "ஐம்பத்தொன்று", "ஐம்பத்திரண்டு", "ஐம்பத்துமூன்று", "ஐம்பத்துநான்கு", "ஐம்பத்தைந்து", "ஐம்பத்தாறு", "ஐம்பத்தேழு", "ஐம்பத்தெட்டு", "ஐம்பத்தொன்பது",
        "அறுபது", "அறுபத்தொன்று", "அறுபத்திரண்டு", "அறுபத்துமூன்று", "அறுபத்துநான்கு", "அறுபத்தைந்து", "அறுபத்தாறு", "அறுபத்தேழு", "அறுபத்தெட்டு", "அறுபத்தொன்பது",
        "எழுபது", "எழுபத்தொன்று", "எழுபத்திரண்டு", "எழுபத்துமூன்று", "எழுபத்துநான்கு", "எழுபத்தைந்து", "எழுபத்தாறு", "எழுபத்தேழு", "எழுபத்தெட்டு", "எழுபத்தொன்பது",
        "எண்பது", "எண்பத்தொன்று", "எண்பத்திரண்டு", "எண்பத்துமூன்று", "எண்பத்துநான்கு", "எண்பத்தைந்து", "எண்பத்தாறு", "எண்பத்தேழு", "எண்பத்தெட்டு", "எண்பத்தொன்பது",
        "தொண்ணூறு", "தொண்ணூற்றொன்று", "தொண்ணூற்றிரண்டு", "தொண்ணூற்றுமூன்று", "தொண்ணூற்றுநான்கு", "தொண்ணூற்றைந்து", "தொண்ணூற்றாறு", "தொண்ணூற்றேழு", "தொண்ணூற்றெட்டு", "தொண்ணூற்றொன்பது"
      ].freeze

      INDIAN_SCALES = [
        [1_000_000_000, "நூறு கோடி"],
        [10_000_000, "கோடி"],
        [100_000, "லட்சம்"],
        [1_000, "ஆயிரம்"]
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
        joiner.to_sym == :and ? "மற்றும்" : GRAMMAR[:conjunction]
      end

      def default_fraction_word
        GRAMMAR[:default_fraction]
      end

      def fraction_numerator_feminine?
        false
      end

      def decimal_separator_word
        "தசமம்"
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

    register :ta, TA
  end
end
