# frozen_string_literal: true

require "bigdecimal"
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

  it "controls minor currency unit output" do
    expect(described_class.to_currency(1, :ru, minor: :always)).to eq("один рубль ноль копеек")
    expect(described_class.to_currency(1, :ru, minor: :nonzero)).to eq("один рубль")
    expect(described_class.to_currency(1.25, :ru, minor: :nonzero)).to eq("один рубль двадцать пять копеек")
    expect(described_class.to_currency(1.25, :ru, minor: :never)).to eq("один рубль")
  end

  it "handles string and BigDecimal currency amounts" do
    expect(described_class.to_currency("21.05", :ru)).to eq("двадцать один рубль пять копеек")
    expect(described_class.to_currency("21,05", :ru)).to eq("двадцать один рубль пять копеек")
    expect(described_class.to_currency("-1,25", :ru)).to eq("минус один рубль двадцать пять копеек")
    expect(described_class.to_currency(BigDecimal("32.02"), :ru)).to eq("тридцать два рубля две копейки")
  end

  it "raises for unsupported currency amount" do
    expect { described_class.to_currency("not-a-number", :ru) }.to raise_error(ArgumentError, 'Unsupported currency amount: "not-a-number"')
  end

  it "raises for unsupported minor currency option" do
    expect { described_class.to_currency(1, :ru, minor: :sometimes) }.to raise_error(ArgumentError, "Unsupported minor option: :sometimes")
  end

  it "raises for unsupported date case option" do
    expect { described_class.to_words("2024-08-21", :ru, date_case: :instrumental) }.to raise_error(ArgumentError, "Unsupported date_case option: :instrumental")
  end

  it "raises for unsupported fraction joiner option" do
    expect { described_class.to_words(0.5, :ru, joiner: :plus) }.to raise_error(ArgumentError, "Unsupported joiner option: :plus")
  end

  it "converts Russian dates with nominative day and genitive year by default" do
    expect(described_class.to_words("2024-08-21", :ru)).to eq("двадцать первое августа две тысячи двадцать четвёртого года")
    expect(described_class.to_words("2024-08-21 14:35:42", :ru)).to eq(
      "двадцать первое августа две тысячи двадцать четвёртого года, четырнадцать часов тридцать пять минут сорок две секунды"
    )
  end

  it "converts Russian dates with genitive day when requested" do
    expect(described_class.to_words("2024-08-21", :ru, date_case: :genitive)).to eq("двадцать первого августа две тысячи двадцать четвёртого года")
    expect(described_class.to_words("2024-08-21 14:35:42", :ru, date_case: :genitive)).to eq(
      "двадцать первого августа две тысячи двадцать четвёртого года, четырнадцать часов тридцать пять минут сорок две секунды"
    )
  end
end
