# frozen_string_literal: true

require "date"
require "time"

module Num2words
  class Converter
    class << self
      def to_words(number, *args, **opts)
        locale = args[0].is_a?(Symbol) ? args[0] : opts[:locale] || I18n.default_locale
        type_only = args[1].is_a?(Symbol) ? args[1] : opts[:only]
        type_short = args[2].is_a?(TrueClass) || args[2].is_a?(FalseClass) ? args[2] : opts[:short] || false

        feminine = opts[:feminine] || false
        style = opts[:style] || :fraction
        word_case = opts[:word_case] || :default
        date_format = opts[:format] || :default

        locale_data = Locales[locale]

        result = case detect_type(number)
                 when :float then to_words_fractional(number, locale, feminine, locale_data, style: style)
                 when :integer then to_words_integer(number, locale, feminine, locale_data)
                 when :datetime then to_words_datetime(number, locale, locale_data, format: date_format, only: type_only, short: type_short)
                 when :date then to_words_date(number, locale, locale_data, format: date_format)
                 when :time then to_words_time(number, locale, locale_data, short: type_short)
                 else nil
                 end

        raise ArgumentError, "Unsupported input type: #{number.inspect}" if result.nil?

        apply_case(result, word_case)
      end

      def to_currency(amount, *args, **opts)
        locale = args.first.is_a?(Symbol) ? args.first : opts[:locale] || I18n.default_locale
        word_case = opts[:word_case] || :downcase
        currency = (opts[:code] || Num2words.default_currency(locale)).to_s.upcase.to_sym

        unless Num2words.available_currencies(locale).include?(currency)
          warn I18n.t("num2words.warnings.currency_not_available",
                      currency: currency, locale: locale) if Num2words.currency_warnings
          currency = Num2words.default_currency(locale)
        end

        currency_data = I18n.t("num2words.currencies.#{currency}", locale: locale) or
          raise ArgumentError, "Currency #{currency} not defined in locale #{locale}"

        major_value, minor_value = sprintf('%.2f', amount).split('.').map(&:to_i)

        parts = [
          to_words(major_value, locale: locale),
          pluralize(major_value, *currency_data[:major_unit]),
          to_words(minor_value, locale: locale, feminine: true),
          pluralize(minor_value, *currency_data[:minor_unit])
        ]

        apply_case(parts.join(" "), word_case)
      end

      private

      def pluralize(number, singular, few, plural)
        number = number.abs
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
        minus_word = locale_data::GRAMMAR[:minus] || "minus"
        conjunction_word = locale_data::GRAMMAR[:conjunction] || "and"
        default_fraction = locale_data::GRAMMAR[:default_fraction] || "parts"
        fractions_data = locale_data::FRACTIONS || {}

        sign_word = number.negative? ? minus_word : ""

        integer_string, fraction_string = number.abs.to_s.split('.', 2)
        integer_value = integer_string.to_i

        return to_words_integer(integer_value, locale, feminine, locale_data) if fraction_string.to_i.zero?

        fraction_string = fraction_string.sub(/0+\z/, "")
        numerator = fraction_string.to_i
        denominator = 10 ** fraction_string.length

        integer_words = to_words_integer(integer_value, locale, feminine, locale_data)

        if locale.to_sym == :en && style == :decimal
          fraction_digits = fraction_string.chars.map { |d| to_words_integer(d.to_i, locale, feminine, locale_data) }
          full_string = [sign_word, integer_words, "point", fraction_digits.join(" ")].reject(&:empty?).join(" ")
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

      def to_words_date(date, locale, locale_data, format: :default)
        date = Date.parse(date.to_s) unless date.is_a?(Date)

        day, month, year = [date.day, date.month, date.year]

        return date.strftime("%d.%m.%Y") if format == :short

        months = locale_data::DATE[:months][format] || locale_data::DATE[:months][:default]
        template = locale_data::DATE_TEMPLATE[format] || locale_data::DATE_TEMPLATE[:default]

        raise ArgumentError, "Months not found for locale #{locale}" unless months
        raise ArgumentError, "Template not found for locale #{locale}" unless template

        day_words = to_words_ordinal(day, locale, format, locale_data, gender: :neuter)
        month_words = months[month - 1]
        year_words = to_words_ordinal(year, locale, format, locale_data)

        template % { day: day_words, month: month_words, year: year_words }
      end

      def to_words_ordinal(value, locale, format, locale_data, gender: :masculine)
        ordinals = locale_data::ORDINALS[format] rescue nil
        raise ArgumentError, "Ordinals not found for locale #{locale}, format #{format}" unless ordinals

        gender_data = ordinals[gender] || ordinals[:masculine]
        raise ArgumentError, "Gender #{gender} not found for locale #{locale}, format #{format}" unless gender_data

        return gender_data[value - 1] if gender_data[value]

        if value > 31
          thousands = (value / 100) * 100
          last_two = value % 100

          base_year = to_words_integer(thousands, locale, false, locale_data)
          last_ordinal = gender_data[last_two - 1] || to_words_integer(last_two, locale, false, locale_data)
          last_ordinal = to_words_integer(last_two, locale, false, locale_data) if locale == :en

          return [base_year, last_ordinal].join(" ")
        end

        to_words_integer(value, locale, false, locale_data)
      end

      def to_words_time(time, locale, locale_data, format: :default, short: false)
        time = Time.parse(time) if time.is_a?(String)

        return time.strftime("%H:%M") if format == :short

        words = locale_data::TIME[:words]
        template = locale_data::TIME_TEMPLATE

        hours = [
          to_words_integer(time.hour, locale, false, locale_data),
          pluralize(time.hour, *words[:hour])
        ].join(" ")
        minutes = [
          to_words_integer(time.min, locale, true, locale_data),
          pluralize(time.min, *words[:minute])
        ].join(" ")
        seconds = [
          to_words_integer(time.sec, locale, true, locale_data),
          pluralize(time.sec, *words[:second])
        ].join(" ")

        format = if short
                   time.min.zero? && time.sec.zero? ? :hours_only : :hours_minutes
                 else
                   format
                 end

        case format
        when :hours_only
          template[:hours_only] % { hours: hours }
        when :hours_minutes
          template[:hours_minutes] % { hours: hours, minutes: minutes }
        when :hours_minutes_seconds, :default
          template[:hours_minutes_seconds] % { hours: hours, minutes: minutes, seconds: seconds }
        else
          raise ArgumentError, "Unsupported time format: #{format}"
        end
      end

      def to_words_datetime(datetime, locale, locale_data, format: :default, only: nil, short: false)
        datetime = DateTime.parse(datetime) if datetime.is_a?(String)

        date_format = short && only == :date ? :short : format
        time_format = short && only == :time ? :short : :default

        date_part = to_words_date(datetime.to_date, locale, locale_data, format: date_format)
        time_part = to_words_time(datetime.to_time, locale, locale_data, format: time_format, short: short)

        return date_part if only == :date
        return time_part if only == :time

        return "#{date_part}, #{time_part}" if short

        template = locale_data::DATETIME_TEMPLATE
        template % { date: date_part, time: time_part }
      end

      def apply_case(text, word_case)
        case word_case
        when :upper then text.upcase
        when :capitalize then text.capitalize
        when :title then text.split.map(&:capitalize).join(" ")
        when :downcase then text.downcase
        else text
        end
      end

      def detect_type(value)
        case value
        when Integer then :integer
        when Float then :float
        when Date then :date
        when Time then :time
        when DateTime then :datetime
        when String
          return :integer if value.match?(/\A-?\d+\z/)
          return :float if value.match?(/\A-?\d+\.\d+\z/)
          return :time if value.match?(/\A\d{1,2}:\d{2}(:\d{2})?\z/)

          # Форматы даты
          return :date if value.match?(/\A\d{1,2}[.\-]\d{1,2}[.\-]\d{2,4}\z/)
          return :date if value.match?(/\A\d{4}-\d{2}-\d{2}\z/)
          return :datetime if value.match?(/\A\d{1,2}[.\-]\d{1,2}[.\-]\d{2,4}\s+\d{1,2}:\d{2}(:\d{2})?\z/)
          return :datetime if value.match?(/\A\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}(:\d{2})?([.,]\d+)?(Z|[+\-]\d{2}:?\d{2})?\z/)

          begin
            date_time = DateTime.parse(value)
            (date_time.hour != 0 || date_time.min != 0 || date_time.sec != 0) ? :datetime : :date
          rescue ArgumentError
            :string
          end
        else
          :unknown
        end
      end
    end
  end
end
