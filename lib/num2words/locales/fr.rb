# frozen_string_literal: true

module Num2words
  module Locales
    module FR
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :fr)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :fr)
      TEENS = I18n.t("num2words.teens", locale: :fr)
      TENS = I18n.t("num2words.tens", locale: :fr)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :fr)
      SCALES = I18n.t("num2words.scales", locale: :fr)

      FRACTIONS = I18n.t("num2words.fractions", locale: :fr)
      GRAMMAR = I18n.t("num2words.grammar", locale: :fr)

      DATE = I18n.t("num2words.date", locale: :fr)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :fr)
      TIME = I18n.t("num2words.time", locale: :fr)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :fr)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :fr)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :fr)

      module_function

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
        "virgule"
      end

      def decimal_fraction_words(fraction_string)
        fraction_string.chars.map { |digit| under_thousand(digit.to_i) }.join(" ")
      end

      def time_unit_feminine?(unit)
        unit == :hour || unit == :minute || unit == :second
      end

      def currency_major_feminine?(currency)
        %i[GBP TRY UAH CZK SEK NOK DKK INR IDR PKR].include?(currency)
      end

      def currency_minor_feminine?(currency)
        %i[ILS BGN SAR].include?(currency)
      end

      def triple_to_words(number, scale_idx, feminine: false)
        words = scale_idx == 1 && number == 1 ? [] : under_thousand(number, feminine: feminine).split

        unless scale_idx.zero?
          scale_forms = SCALES[scale_idx]
          words << (number == 1 ? scale_forms[0] : scale_forms[2])
        end

        words
      end

      def date_day(day, format:, date_case:)
        return "premier" if day == 1

        under_thousand(day)
      end

      def date_year(year, format:)
        groups = year.to_s
                     .chars.reverse.each_slice(3).map(&:reverse)
                     .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          scale_index = groups.size - index - 1
          words.concat triple_to_words(group_value, scale_index)
        end

        words.join(" ")
      end

      def under_thousand(number, feminine: false)
        hundreds = number / 100
        rest = number % 100

        return under_hundred(rest, feminine: feminine) if hundreds.zero?

        hundred_words = if hundreds == 1
                          HUNDREDS[1]
                        elsif rest.zero?
                          HUNDREDS[hundreds]
                        else
                          HUNDREDS[hundreds].sub(/s\z/, "")
                        end

        return hundred_words if rest.zero?

        [hundred_words, under_hundred(rest, feminine: feminine)].join(" ")
      end

      def under_hundred(number, feminine: false)
        ones_data = feminine ? ONES_FEM : ONES_MASC

        return ones_data[number] if number < 10
        return TEENS[number - 10] if number < 20

        case number
        when 20..69
          tens = number / 10
          ones = number % 10
          return TENS[tens] if ones.zero?
          return "#{TENS[tens]} et #{ones_data[ones]}" if ones == 1

          "#{TENS[tens]} #{ones_data[ones]}"
        when 70..79
          teen = number - 60
          return "soixante et #{TEENS[1]}" if teen == 11

          "soixante #{under_hundred(teen, feminine: feminine)}"
        when 80
          "quatre-vingts"
        else
          rest = number - 80
          return "quatre-vingt" if rest.zero?

          "quatre-vingt #{under_hundred(rest, feminine: feminine)}"
        end
      end

      def pluralize(number, singular, _few, plural)
        number.abs == 1 ? singular : plural
      end
    end

    register :fr, FR
  end
end
