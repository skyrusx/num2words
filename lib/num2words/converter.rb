# frozen_string_literal: true

module Num2words
  class Converter
    class << self
      # number — целое число (0..10^12-1)
      def to_words(number, *args, **opts)
        locale = args.first.is_a?(Symbol) ? args.first : opts[:locale] || :ru
        feminine = opts.delete(:feminine) || false

        locale_data = Locales[locale]

        number = Integer(number)
        return (feminine ? locale_data::ONES_FEM[0] : locale_data::ONES_MASC[0]) if number.zero?

        groups = number.to_s
                       .chars.reverse.each_slice(3).map(&:reverse)
                       .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |grp, idx|
          scale_idx = groups.size - idx - 1
          fem = (scale_idx == 1) || feminine # тысячи — жен. род
          words.concat triple_to_words(grp, scale_idx, locale_data, feminine: fem)
        end
        words.join(" ")
      end

      # amount может быть String, Integer, Float, BigDecimal
      def to_currency(amount, *args, **opts)
        locale = args.first.is_a?(Symbol) ? args.first : opts[:locale] || :ru
        locale_data = Locales[locale]

        str = amount.to_s
        rub_str, kop_str = str.split(".")
        rub = Integer(rub_str)
        # всегда 2 знака для копеек; обрезаем лишние, дополняем недостающие
        kop = (kop_str || "0")[0, 2].ljust(2, "0").to_i

        rub_words = to_words(rub, locale: locale)
        rub_name  = pluralize(rub, *locale_data::RUB)

        kop_words = to_words(kop, locale: locale, feminine: true)
        kop_name  = pluralize(kop, *locale_data::KOP)

        "#{rub_words} #{rub_name} #{kop_words} #{kop_name}"
      end

      private

      def pluralize(n, one, few, many)
        return many if (11..14).include?(n % 100)
        case n % 10
        when 1 then one
        when 2..4 then few
        else many
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
    end
  end
end
