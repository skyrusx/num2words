# frozen_string_literal: true

require "num2words"

RSpec.describe "Portuguese locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :pt)).to eq("zero")
      expect(Num2words.to_words(1, :pt)).to eq("um")
      expect(Num2words.to_words(2, :pt)).to eq("dois")
      expect(Num2words.to_words(5, :pt)).to eq("cinco")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :pt)).to eq("dez")
      expect(Num2words.to_words(11, :pt)).to eq("onze")
      expect(Num2words.to_words(19, :pt)).to eq("dezenove")
      expect(Num2words.to_words(20, :pt)).to eq("vinte")
      expect(Num2words.to_words(21, :pt)).to eq("vinte e um")
      expect(Num2words.to_words(24, :pt)).to eq("vinte e quatro")
      expect(Num2words.to_words(35, :pt)).to eq("trinta e cinco")
      expect(Num2words.to_words(99, :pt)).to eq("noventa e nove")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :pt)).to eq("cem")
      expect(Num2words.to_words(101, :pt)).to eq("cento e um")
      expect(Num2words.to_words(105, :pt)).to eq("cento e cinco")
      expect(Num2words.to_words(124, :pt)).to eq("cento e vinte e quatro")
      expect(Num2words.to_words(999, :pt)).to eq("novecentos e noventa e nove")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :pt)).to eq("mil")
      expect(Num2words.to_words(2_000, :pt)).to eq("dois mil")
      expect(Num2words.to_words(5_000, :pt)).to eq("cinco mil")
      expect(Num2words.to_words(21_000, :pt)).to eq("vinte e um mil")
      expect(Num2words.to_words(1_001, :pt)).to eq("mil um")
      expect(Num2words.to_words(2_002, :pt)).to eq("dois mil dois")
      expect(Num2words.to_words(5_005, :pt)).to eq("cinco mil cinco")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :pt)).to eq("um milhão")
      expect(Num2words.to_words(2_000_000, :pt)).to eq("dois milhões")
      expect(Num2words.to_words(5_000_000, :pt)).to eq("cinco milhões")
      expect(Num2words.to_words(1_234_567, :pt)).to eq(
        "um milhão duzentos e trinta e quatro mil quinhentos e sessenta e sete"
      )
      expect(Num2words.to_words(9_876_543_210, :pt)).to eq(
        "nove bilhões oitocentos e setenta e seis milhões quinhentos e quarenta e três mil duzentos e dez"
      )
    end
  end

  context "feminine option" do
    it "changes one, two and hundreds where applicable" do
      expect(Num2words.to_words(1, :pt, feminine: true)).to eq("uma")
      expect(Num2words.to_words(2, :pt, feminine: true)).to eq("duas")
      expect(Num2words.to_words(21, :pt, feminine: true)).to eq("vinte e uma")
      expect(Num2words.to_words(201, :pt, feminine: true)).to eq("duzentas e uma")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :pt)).to eq("menos um")
      expect(Num2words.to_words(-21, :pt)).to eq("menos vinte e um")
      expect(Num2words.to_words("-42", :pt)).to eq("menos quarenta e dois")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :pt)).to eq("três inteiros cinco décimos")
      expect(Num2words.to_words("3,5", :pt)).to eq("três inteiros cinco décimos")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :pt)).to eq("zero inteiros cinco décimos")
      expect(Num2words.to_words(2.25, :pt)).to eq("dois inteiros vinte e cinco centésimos")
      expect(Num2words.to_words(3.01, :pt)).to eq("três inteiros um centésimo")
      expect(Num2words.to_words(-1.2, :pt)).to eq("menos um inteiros dois décimos")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :pt, joiner: :and)).to eq("zero e cinco décimos")
      expect(Num2words.to_words(12.12, :pt, style: :decimal)).to eq("doze vírgula um dois")
      expect(Num2words.to_words("3,05", :pt, style: :decimal)).to eq("três vírgula zero cinco")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :pt)).to eq("um euro zero cêntimos")
      expect(Num2words.to_currency(2, :pt)).to eq("dois euros zero cêntimos")
      expect(Num2words.to_currency("12.50", :pt)).to eq("doze euros cinquenta cêntimos")
      expect(Num2words.to_currency("1.01", :pt, code: :GBP)).to eq("uma libra um penny")
      expect(Num2words.to_currency("12.50", :pt, code: :BRL)).to eq("doze reais cinquenta centavos")
      expect(Num2words.to_currency(12, :pt, minor: :nonzero)).to eq("doze euros")
      expect(Num2words.to_currency(12.5, :pt, minor: :never)).to eq("doze euros")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :pt)).to eq("vinte e um de agosto de dois mil vinte e quatro")
      expect(Num2words.to_words("14:35:42", :pt)).to eq("catorze horas trinta e cinco minutos quarenta e dois segundos")
      expect(Num2words.to_words("2024-08-21 14:35:42", :pt)).to eq(
        "vinte e um de agosto de dois mil vinte e quatro, catorze horas trinta e cinco minutos quarenta e dois segundos"
      )
    end
  end
end
