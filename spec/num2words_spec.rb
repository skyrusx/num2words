# frozen_string_literal: true

require "num2words"

RSpec.describe Num2words do
  it "converts integers" do
    expect(described_class.to_words(0)).to eq("ноль")
    expect(described_class.to_words(21)).to eq("двадцать один")
    expect(described_class.to_words(105)).to eq("сто пять")
    expect(described_class.to_words(124)).to eq("сто двадцать четыре")
    expect(described_class.to_words(1_000)).to eq("одна тысяча")
    expect(described_class.to_words(2_000)).to eq("две тысячи")
    expect(described_class.to_words(5_000)).to eq("пять тысяч")
    expect(described_class.to_words(1_000_000)).to eq("один миллион")
    expect(described_class.to_words(2_000_000)).to eq("два миллиона")
    expect(described_class.to_words(5_000_000)).to eq("пять миллионов")
    expect(described_class.to_words(1_234_567)).to eq("один миллион двести тридцать четыре тысячи пятьсот шестьдесят семь")
  end

  it "handles currency with correct gender and plural" do
    expect(described_class.to_currency(1)).to eq("один рубль ноль копеек")
    expect(described_class.to_currency(2)).to eq("два рубля ноль копеек")
    expect(described_class.to_currency(5)).to eq("пять рублей ноль копеек")
    expect(described_class.to_currency(21.01)).to eq("двадцать один рубль одна копейка")
    expect(described_class.to_currency(32.02)).to eq("тридцать два рубля две копейки")
    expect(described_class.to_currency(45.15)).to eq("сорок пять рублей пятнадцать копеек")
    expect(described_class.to_currency(1001.05)).to eq("одна тысяча один рубль пять копеек")
    expect(described_class.to_currency(1_234_567.89)).to eq("один миллион двести тридцать четыре тысячи пятьсот шестьдесят семь рублей восемьдесят девять копеек")
  end
end
