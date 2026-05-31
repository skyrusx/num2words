# frozen_string_literal: true

require "num2words"

RSpec.describe Num2words do
  subject(:to_words) { |n| described_class.to_words(n) }

  context "целые базовые" do
    it "ноль и единицы" do
      expect(described_class.to_words(0, :ru)).to eq("ноль")
      expect(described_class.to_words(1, :ru)).to eq("один")
      expect(described_class.to_words(2, :ru)).to eq("два")
      expect(described_class.to_words(5, :ru)).to eq("пять")
    end

    it "десятки и особые 11..19" do
      expect(described_class.to_words(10, :ru)).to eq("десять")
      expect(described_class.to_words(11, :ru)).to eq("одиннадцать")
      expect(described_class.to_words(19, :ru)).to eq("девятнадцать")
      expect(described_class.to_words(20, :ru)).to eq("двадцать")
      expect(described_class.to_words(21, :ru)).to eq("двадцать один")
      expect(described_class.to_words(24, :ru)).to eq("двадцать четыре")
      expect(described_class.to_words(35, :ru)).to eq("тридцать пять")
      expect(described_class.to_words(99, :ru)).to eq("девяносто девять")
    end

    it "сотни и сотни+хвост" do
      expect(described_class.to_words(100, :ru)).to eq("сто")
      expect(described_class.to_words(101, :ru)).to eq("сто один")
      expect(described_class.to_words(105, :ru)).to eq("сто пять")
      expect(described_class.to_words(124, :ru)).to eq("сто двадцать четыре")
      expect(described_class.to_words(999, :ru)).to eq("девятьсот девяносто девять")
    end
  end

  context "тысячи (женский род для единиц в разряде тысяч)" do
    it "ровные и с хвостом" do
      expect(described_class.to_words(1_000, :ru)).to eq("одна тысяча")
      expect(described_class.to_words(2_000, :ru)).to eq("две тысячи")
      expect(described_class.to_words(5_000, :ru)).to eq("пять тысяч")
      expect(described_class.to_words(21_000, :ru)).to eq("двадцать одна тысяча")
      expect(described_class.to_words(22_000, :ru)).to eq("двадцать две тысячи")
      expect(described_class.to_words(25_000, :ru)).to eq("двадцать пять тысяч")
    end

    it "тысячи + единицы в младшем разряде" do
      expect(described_class.to_words(1_001, :ru)).to eq("одна тысяча один")
      expect(described_class.to_words(2_002, :ru)).to eq("две тысячи два")
      expect(described_class.to_words(5_005, :ru)).to eq("пять тысяч пять")
    end
  end

  context "миллионы/миллиарды (склонения разрядов)" do
    it "ровные" do
      expect(described_class.to_words(1_000_000, :ru)).to eq("один миллион")
      expect(described_class.to_words(2_000_000, :ru)).to eq("два миллиона")
      expect(described_class.to_words(5_000_000, :ru)).to eq("пять миллионов")
      expect(described_class.to_words(1_000_000_000, :ru)).to eq("один миллиард")
      expect(described_class.to_words(2_000_000_000, :ru)).to eq("два миллиарда")
      expect(described_class.to_words(5_000_000_000, :ru)).to eq("пять миллиардов")
    end

    it "с составным хвостом" do
      expect(described_class.to_words(1_234_567, :ru)).to eq("один миллион двести тридцать четыре тысячи пятьсот шестьдесят семь")
      expect(described_class.to_words(1_000_001, :ru)).to eq("один миллион один")
      expect(described_class.to_words(2_021_004, :ru)).to eq("два миллиона двадцать одна тысяча четыре")
    end
  end

  context "женский род (feminine: true) для единичных форм" do
    it "меняет 1→одна, 2→две" do
      expect(described_class.to_words(1, :ru, feminine: true)).to eq("одна")
      expect(described_class.to_words(2, :ru, feminine: true)).to eq("две")
      expect(described_class.to_words(3, :ru, feminine: true)).to eq("три") # нейтр.
    end

    it "не ломает составные" do
      expect(described_class.to_words(21, :ru, feminine: true)).to eq("двадцать одна")
      expect(described_class.to_words(22, :ru, feminine: true)).to eq("двадцать две")
    end
  end

  context "отрицательные числа" do
    it "добавляет 'минус' из локали" do
      expect(described_class.to_words(-1, :ru)).to eq("минус один")
      expect(described_class.to_words(-21, :ru)).to eq("минус двадцать один")
      expect(described_class.to_words(-1_000, :ru)).to eq("минус одна тысяча")
    end
  end

  context "вход как строка-число" do
    it "распознаёт целое" do
      expect(described_class.to_words("007", :ru)).to eq("семь")
      expect(described_class.to_words("-42", :ru)).to eq("минус сорок два")
    end

    it "распознаёт вещественное" do
      # см. раздел дробей ниже; здесь просто факт распознавания
      expect(described_class.to_words("3.5", :ru)).to be_a(String)
    end
  end

  context "дробные (по умолчанию формальный стиль через FRACTIONS и GRAMMAR[:conjunction])" do
    it "0.5 -> 'ноль целых пять десятых'" do
      expect(described_class.to_words(0.5, :ru)).to eq("ноль целых пять десятых")
    end

    it "2.25 -> 'два целых двадцать пять сотых'" do
      expect(described_class.to_words(2.25, :ru)).to eq("два целых двадцать пять сотых")
    end

    it "3.01 -> 'три целых одна сотая' (обрезка хвостовых нулей)" do
      expect(described_class.to_words(3.01, :ru)).to eq("три целых одна сотая")
    end

    it "-1.2 -> 'минус один целых две десятые' (знак и род для числителя)" do
      expect(described_class.to_words(-1.2, :ru)).to eq("минус один целых две десятые")
    end

    it "uses informal joiner with joiner: :and" do
      expect(described_class.to_words(0.5, :ru, joiner: :and)).to eq("ноль и пять десятых")
      expect(described_class.to_words(2.25, :ru, joiner: :and)).to eq("два и двадцать пять сотых")
      expect(described_class.to_words(3.01, :ru, joiner: :and)).to eq("три и одна сотая")
      expect(described_class.to_words(-1.2, :ru, joiner: :and)).to eq("минус один и две десятые")
    end
  end

  context "грани диапазонов и большие числа" do
    it "крупные составные" do
      expect(described_class.to_words(9_876_543_210, :ru)).to eq(
                                                                "девять миллиардов восемьсот семьдесят шесть миллионов пятьсот сорок три тысячи двести десять"
                                                              )
    end

    it "группы с 11..19 внутри" do
      expect(described_class.to_words(11_011, :ru)).to eq("одиннадцать тысяч одиннадцать")
      expect(described_class.to_words(1_011_011, :ru)).to eq("один миллион одиннадцать тысяч одиннадцать")
    end
  end

  context "регистры (word_case)" do
    it "upper / downcase / capitalize / title" do
      base = "двадцать один"
      expect(described_class.to_words(21, :ru, word_case: :upper)).to eq(base.upcase)
      expect(described_class.to_words(21, :ru, word_case: :downcase)).to eq(base)
      expect(described_class.to_words(21, :ru, word_case: :capitalize)).to eq("Двадцать один")
      expect(described_class.to_words(21, :ru, word_case: :title)).to eq("Двадцать Один")
    end
  end
end
