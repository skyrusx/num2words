# frozen_string_literal: true

module Num2words
  class Converter
    class << self
      def to_words(number, *args, **opts)
        locale   = args.first.is_a?(Symbol) ? args.first : opts[:locale] || I18n.default_locale
        feminine = opts[:feminine] || false
        style    = opts[:style] || :fraction
        locale_data = Locales[locale]

        return to_words_fractional(number, locale, feminine, locale_data, style: style) if number.is_a?(Float)
        return to_words_integer(number, locale, feminine, locale_data)
      end

      def to_currency(amount, *args, **opts)
        locale      = args.first.is_a?(Symbol) ? args.first : opts[:locale] || I18n.default_locale
        locale_data = Locales[locale]

        major_str, minor_str = sprintf('%.2f', amount).split('.')
        major_value = major_str.to_i
        minor_value = minor_str.to_i

        major_words = to_words(major_value, locale: locale)
        major_name  = pluralize(major_value, *locale_data::MAJOR_UNIT)

        minor_words = to_words(minor_value, locale: locale, feminine: true)
        minor_name  = pluralize(minor_value, *locale_data::MINOR_UNIT)

        [major_words, major_name, minor_words, minor_name].join(" ")
      end

      private

      def pluralize(number, singular, few, plural)
        return plural if (11..14).include?(number % 100)

        case number % 10
        when 1 then singular
        when 2..4 then few
        else plural
        end
      end

      # n — 0..999, scale_idx — индекс разряда (0 — единицы, 1 — тысячи, ...)
      # feminine: true — использовать женский род для единиц (нужно для тысяч/копеек)
      def triple_to_words(n, scale_idx, local_data, feminine: false)
        return [] if n.zero?
        words = []

        words << local_data::HUNDREDS[n / 100] if n >= 100
        rest = n % 100

        if rest.between?(10, 19)
          words << local_data::TEENS[rest - 10]
        else
          words << local_data::TENS[rest / 10] if rest >= 20
          ones = rest % 10
          words << (feminine ? local_data::ONES_FEM[ones] : local_data::ONES_MASC[ones]) if ones.positive?
        end

        words << pluralize(n, *local_data::SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      def to_words_fractional(number, locale, feminine, locale_data, style: :fraction)
        minus_word       = locale_data::GRAMMAR[:minus] || "minus"
        conjunction_word = locale_data::GRAMMAR[:conjunction] || "and"
        default_fraction = locale_data::GRAMMAR[:default_fraction] || "parts"
        fractions_data   = locale_data::FRACTIONS || {}

        sign_word = number.negative? ? minus_word : ""

        integer_string, fraction_string = number.abs.to_s.split('.', 2)
        integer_value = integer_string.to_i

        return to_words_integer(integer_value, locale, feminine, locale_data) if fraction_string.to_i.zero?

        fraction_string = fraction_string.sub(/0+\z/, "")
        numerator   = fraction_string.to_i
        denominator = 10 ** fraction_string.length

        integer_words = to_words_integer(integer_value, locale, feminine, locale_data)

        if locale.to_sym == :en && style == :decimal
          fraction_digits = fraction_string.chars.map { |d| to_words_integer(d.to_i, locale, feminine, locale_data) }
          full_string = [sign_word, integer_words, "point", fraction_digits.join(" ")].join(" ")
          return full_string
        end

        numerator_words = to_words_integer(numerator, locale, (locale.to_sym == :ru ? true : feminine), locale_data)

        denom_forms = fractions_data[denominator] || fractions_data[denominator.to_s] # массив склонений
        denominator_words = denom_forms.is_a?(Array) ? pluralize(numerator, *denom_forms) : default_fraction

        [sign_word, integer_words, conjunction_word, numerator_words, denominator_words].reject(&:empty?).join(" ")
      end

      def to_words_integer(number, locale, feminine, locale_data)
        integer_value = Integer(number)

        return (feminine ? locale_data::ONES_FEM[0] : locale_data::ONES_MASC[0]) if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(3).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          scale_index = groups.size - index - 1
          group_feminine = (scale_index == 1) || feminine
          words.concat triple_to_words(group_value, scale_index, locale_data, feminine: group_feminine)
        end

        words.join(" ")
      end
    end
  end
end
