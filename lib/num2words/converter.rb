# frozen_string_literal: true

module Num2words
  class Converter
    ONES_MASC = %w[ноль один два три четыре пять шесть семь восемь девять].freeze
    ONES_FEM  = %w[ноль одна две три четыре пять шесть семь восемь девять].freeze

    TEENS = %w[десять одиннадцать двенадцать тринадцать четырнадцать пятнадцать
               шестнадцать семнадцать восемнадцать девятнадцать].freeze

    TENS = [nil, nil, "двадцать", "тридцать", "сорок", "пятьдесят",
            "шестьдесят", "семьдесят", "восемьдесят", "девяносто"].freeze

    HUNDREDS = [nil, "сто", "двести", "триста", "четыреста", "пятьсот",
                "шестьсот", "семьсот", "восемьсот", "девятьсот"].freeze

    # формы: [one, few, many]
    SCALES = [
      ["", "", ""], # 10^0 (единицы)
      %w[тысяча тысячи тысяч], # 10^3
      %w[миллион миллиона миллионов], # 10^6
      %w[миллиард миллиарда миллиардов], # 10^9
      %w[триллион триллиона триллионов] # 10^12
    ].freeze

    RUB = %w[рубль рубля рублей].freeze
    KOP = %w[копейка копейки копеек].freeze

    class << self
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
      def triple_to_words(n, scale_idx, feminine: false)
        return [] if n.zero?

        words = []
        words << HUNDREDS[n / 100] if n >= 100

        rest = n % 100
        if rest.between?(10, 19)
          words << TEENS[rest - 10]
        else
          words << TENS[rest / 10] if rest >= 20
          ones = rest % 10
          if ones.positive?
            words << (feminine ? ONES_FEM[ones] : ONES_MASC[ones])
          end
        end

        # добавляем наименование разряда (кроме единиц)
        words << pluralize(n, *SCALES[scale_idx]) unless scale_idx.zero?
        words.compact
      end

      # number — целое число (0..10^12-1)
      def to_words(number, feminine: false)
        number = Integer(number)
        return (feminine ? ONES_FEM[0] : ONES_MASC[0]) if number.zero?

        groups = number.to_s
                       .chars.reverse.each_slice(3).map(&:reverse)
                       .map(&:join).map!(&:to_i).reverse

        words = []
        groups.each_with_index do |grp, idx|
          scale_idx = groups.size - idx - 1
          fem = (scale_idx == 1) || feminine # тысячи — жен. род
          words.concat triple_to_words(grp, scale_idx, feminine: fem)
        end
        words.join(" ")
      end

      # amount может быть String, Integer, Float, BigDecimal
      def to_currency(amount)
        str = amount.to_s
        rub_str, kop_str = str.split(".")
        rub = Integer(rub_str)
        # всегда 2 знака для копеек; обрезаем лишние, дополняем недостающие
        kop = (kop_str || "0")[0, 2].ljust(2, "0").to_i

        rub_words = to_words(rub)
        rub_name  = pluralize(rub, *RUB)

        kop_words = to_words(kop, feminine: true)
        kop_name  = pluralize(kop, *KOP)

        "#{rub_words} #{rub_name} #{kop_words} #{kop_name}"
      end
    end
  end
end
