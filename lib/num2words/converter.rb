# frozen_string_literal: true

require "date"
require "time"
require "bigdecimal"

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
        date_case = opts[:date_case] || :default
        joiner = opts[:joiner] || :default

        validate_option!(:date_case, date_case, %i[default genitive])
        validate_option!(:joiner, joiner, %i[default and])

        locale_data = Locales[locale]

        result = case detect_type(number)
                 when :float then to_words_fractional(number, locale, feminine, locale_data, style: style, joiner: joiner)
                 when :integer then to_words_integer(number, locale, feminine, locale_data)
                 when :datetime then to_words_datetime(number, locale, locale_data, format: date_format, only: type_only, short: type_short, date_case: date_case)
                 when :date then to_words_date(number, locale, locale_data, format: date_format, date_case: date_case)
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
        minor = opts[:minor] || :always

        validate_option!(:minor, minor, %i[always nonzero never])

        unless Num2words.available_currencies(locale).include?(currency)
          warn I18n.t("num2words.warnings.currency_not_available",
                      currency: currency, locale: locale) if Num2words.currency_warnings
          currency = Num2words.default_currency(locale)
        end

        currency_data = I18n.t("num2words.currencies.#{currency}", locale: locale) or
          raise ArgumentError, "Currency #{currency} not defined in locale #{locale}"

        decimal_amount = decimal_currency_amount(amount)
        major_value, minor_value = format('%.2f', decimal_amount.abs).split('.').map(&:to_i)
        major_feminine = locale_currency_major_feminine?(Locales[locale], currency)
        minor_feminine = locale_currency_minor_feminine?(Locales[locale], currency)

        parts = [
          locale_currency_number_words(Locales[locale], major_value, currency, unit: :major, locale: locale, feminine: major_feminine),
          locale_pluralize(Locales[locale], major_value, currency_data[:major_unit])
        ]

        include_minor = minor == :always || (minor == :nonzero && minor_value.positive?)
        if include_minor
          parts.concat([
            locale_currency_number_words(Locales[locale], minor_value, currency, unit: :minor, locale: locale, feminine: minor_feminine),
            locale_pluralize(Locales[locale], minor_value, currency_data[:minor_unit])
          ])
        end

        parts.unshift(locale_minus_word(Locales[locale])) if decimal_amount.negative?

        apply_case(locale_join_currency_parts(Locales[locale], parts), word_case)
      end

      private

      def validate_option!(name, value, allowed_values)
        return if allowed_values.include?(value)

        raise ArgumentError, "Unsupported #{name} option: #{value.inspect}"
      end

      def decimal_currency_amount(amount)
        return amount if amount.is_a?(BigDecimal)

        normalized_amount = amount.is_a?(String) ? amount.tr(",", ".") : amount.to_s
        BigDecimal(normalized_amount)
      rescue ArgumentError
        raise ArgumentError, "Unsupported currency amount: #{amount.inspect}"
      end

      def pluralize(number, singular, few, plural)
        number = number.abs
        return plural if (11..14).include?(number % 100)

        case number % 10
        when 1 then singular
        when 2..4 then few
        else plural
        end
      end

      def locale_pluralize(locale_data, number, forms)
        return locale_data.pluralize(number, *forms) if locale_data.respond_to?(:pluralize)

        pluralize(number, *forms)
      end

      def locale_currency_major_feminine?(locale_data, currency)
        return locale_data.currency_major_feminine?(currency) if locale_data.respond_to?(:currency_major_feminine?)

        false
      end

      def locale_currency_minor_feminine?(locale_data, currency)
        return locale_data.currency_minor_feminine?(currency) if locale_data.respond_to?(:currency_minor_feminine?)

        true
      end

      def locale_currency_number_words(locale_data, number, currency, unit:, locale:, feminine:)
        if locale_data.respond_to?(:currency_number_words)
          return locale_data.currency_number_words(number, currency, unit: unit)
        end

        to_words(number, locale: locale, feminine: feminine)
      end

      def locale_join_currency_parts(locale_data, parts)
        return locale_data.join_currency_parts(parts) if locale_data.respond_to?(:join_currency_parts)

        parts.join(" ").strip
      end

      def locale_time_unit_feminine?(locale_data, unit, default)
        return locale_data.time_unit_feminine?(unit) if locale_data.respond_to?(:time_unit_feminine?)

        default
      end

      def locale_time_number_words(locale_data, number, unit, locale, feminine)
        if locale_data.respond_to?(:time_number_words)
          return locale_data.time_number_words(number, unit: unit)
        end

        to_words_integer(number, locale, feminine, locale_data)
      end

      def locale_join_time_words(locale_data, number_words, unit_words)
        return locale_data.join_time_words(number_words, unit_words) if locale_data.respond_to?(:join_time_words)

        [number_words, unit_words].join(" ")
      end

      def locale_minus_word(locale_data)
        return locale_data.minus_word if locale_data.respond_to?(:minus_word)

        locale_data::GRAMMAR[:minus]
      end

      def locale_fraction_joiner(locale_data, joiner)
        return locale_data.fraction_joiner(joiner) if locale_data.respond_to?(:fraction_joiner)

        locale_data::GRAMMAR[:conjunction]
      end

      def locale_default_fraction_word(locale_data)
        return locale_data.default_fraction_word if locale_data.respond_to?(:default_fraction_word)

        locale_data::GRAMMAR[:default_fraction]
      end

      def locale_decimal_separator_word(locale_data)
        return locale_data.decimal_separator_word if locale_data.respond_to?(:decimal_separator_word)

        locale_data::GRAMMAR[:decimal_separator]
      end

      def locale_join_decimal_words(locale_data, words)
        return locale_data.join_decimal_words(words) if locale_data.respond_to?(:join_decimal_words)

        words.compact.reject(&:empty?).join(" ")
      end

      def locale_join_fraction_words(locale_data, words)
        return locale_data.join_fraction_words(words) if locale_data.respond_to?(:join_fraction_words)

        words.reject(&:empty?).join(" ")
      end

      # n — 0..999, scale_idx — индекс разряда (0 — единицы, 1 — тысячи, ...)
      # feminine: true — использовать женский род для единиц (нужно для тысяч/копеек)
      def triple_to_words(n, scale_idx, local_data, feminine: false, locale: nil)
        return [] if n.zero?

        if local_data.respond_to?(:triple_to_words)
          return local_data.triple_to_words(n, scale_idx, feminine: feminine)
        end

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

        words << locale_pluralize(local_data, n, local_data::SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      def to_words_fractional(number, locale, feminine, locale_data, style: :fraction, joiner: :default)
        minus_word = locale_minus_word(locale_data)
        conjunction_word = locale_fraction_joiner(locale_data, joiner)
        default_fraction = locale_default_fraction_word(locale_data)
        fractions_data = locale_data::FRACTIONS || {}

        negative = number.is_a?(String) ? number.start_with?("-") : number.negative?
        sign_word = negative ? minus_word : ""

        absolute_number = number.is_a?(String) ? number.sub(/\A-/, "").tr(",", ".") : number.abs.to_s
        integer_string, fraction_string = absolute_number.split('.', 2)
        integer_value = integer_string.to_i

        return to_words_integer(integer_value, locale, feminine, locale_data) if fraction_string.to_i.zero?

        fraction_string = fraction_string.sub(/0+\z/, "")
        numerator = fraction_string.to_i
        denominator = 10 ** fraction_string.length

        integer_words = to_words_integer(integer_value, locale, feminine, locale_data)

        if style == :decimal && locale_data.respond_to?(:decimal_fraction_words)
          fraction_digits = locale_data.decimal_fraction_words(fraction_string)
          return locale_join_decimal_words(locale_data, [sign_word, integer_words, locale_decimal_separator_word(locale_data), fraction_digits])
        end

        numerator_feminine = locale_data.respond_to?(:fraction_numerator_feminine?) ? locale_data.fraction_numerator_feminine? : feminine
        numerator_words = to_words_integer(numerator, locale, numerator_feminine, locale_data)

        denom_forms = fractions_data[denominator] || fractions_data[denominator.to_s] # массив склонений
        denominator_words = denom_forms.is_a?(Array) ? locale_pluralize(locale_data, numerator, denom_forms) : default_fraction

        locale_join_fraction_words(locale_data, [sign_word, integer_words, conjunction_word, numerator_words, denominator_words])
      end

      def to_words_integer(number, locale, feminine, locale_data)
        return locale_data.integer_to_words(number, feminine: feminine) if locale_data.respond_to?(:integer_to_words)

        integer_value = Integer(number)

        minus_word = locale_minus_word(locale_data)
        negative = integer_value.negative?
        integer_value = integer_value.abs

        return (feminine ? locale_data::ONES_FEM[0] : locale_data::ONES_MASC[0]) if integer_value.zero?

        groups = integer_value.to_s
                              .chars.reverse.each_slice(3).map(&:reverse)
                              .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |group_value, index|
          scale_index = groups.size - index - 1
          group_feminine = (locale_data.respond_to?(:feminine_group?) && locale_data.feminine_group?(scale_index)) || feminine
          words.concat triple_to_words(group_value, scale_index, locale_data, feminine: group_feminine, locale: locale)
        end

        words.unshift(minus_word) if negative
        words.join(" ")
      end

      def to_words_date(date, locale, locale_data, format: :default, date_case: :default)
        date = Date.parse(date.to_s) unless date.is_a?(Date)

        day, month, year = [date.day, date.month, date.year]

        return date.strftime("%d.%m.%Y") if format == :short

        months = locale_data::DATE[:months][format] || locale_data::DATE[:months][:default]
        template = locale_data::DATE_TEMPLATE[format] || locale_data::DATE_TEMPLATE[:default]

        raise ArgumentError, "Months not found for locale #{locale}" unless months
        raise ArgumentError, "Template not found for locale #{locale}" unless template

        day_gender = date_case.to_sym == :genitive ? :masculine : :neuter
        day_words = if locale_data.respond_to?(:date_day)
                      locale_data.date_day(day, format: format, date_case: date_case)
                    else
                      to_words_ordinal(day, locale, format, locale_data, gender: day_gender)
                    end
        month_words = months[month - 1]
        year_words = if locale_data.respond_to?(:date_year)
                       locale_data.date_year(year, format: format)
                     else
                       to_words_ordinal(year, locale, format, locale_data)
                     end

        template % { day: day_words, month: month_words, year: year_words }
      end

      def to_words_ordinal(value, locale, format, locale_data, gender: :masculine)
        ordinals = locale_data::ORDINALS[format] rescue nil
        raise ArgumentError, "Ordinals not found for locale #{locale}, format #{format}" unless ordinals

        gender_data = ordinals[gender] || ordinals[:masculine]
        raise ArgumentError, "Gender #{gender} not found for locale #{locale}, format #{format}" unless gender_data

        return gender_data[value - 1] if value.between?(1, gender_data.length)

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

        hour_feminine = locale_time_unit_feminine?(locale_data, :hour, false)
        minute_feminine = locale_time_unit_feminine?(locale_data, :minute, true)
        second_feminine = locale_time_unit_feminine?(locale_data, :second, true)

        hours = locale_join_time_words(locale_data,
          locale_time_number_words(locale_data, time.hour, :hour, locale, hour_feminine),
          locale_pluralize(locale_data, time.hour, words[:hour])
        )
        minutes = locale_join_time_words(locale_data,
          locale_time_number_words(locale_data, time.min, :minute, locale, minute_feminine),
          locale_pluralize(locale_data, time.min, words[:minute])
        )
        seconds = locale_join_time_words(locale_data,
          locale_time_number_words(locale_data, time.sec, :second, locale, second_feminine),
          locale_pluralize(locale_data, time.sec, words[:second])
        )

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

      def to_words_datetime(datetime, locale, locale_data, format: :default, only: nil, short: false, date_case: :default)
        datetime = DateTime.parse(datetime) if datetime.is_a?(String)

        date_format = short && only == :date ? :short : format
        time_format = short && only == :time ? :short : :default

        date_part = to_words_date(datetime.to_date, locale, locale_data, format: date_format, date_case: date_case)
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
        when DateTime then :datetime
        when Date then :date
        when Time then :time
        when String
          return :integer if value.match?(/\A-?\d+\z/)
          return :float if value.match?(/\A-?\d+[\.,]\d+\z/)
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
