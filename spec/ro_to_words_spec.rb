# frozen_string_literal: true

require "num2words"

RSpec.describe "Romanian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ro)).to eq("zero")
      expect(Num2words.to_words(1, :ro)).to eq("unu")
      expect(Num2words.to_words(2, :ro)).to eq("doi")
      expect(Num2words.to_words(5, :ro)).to eq("cinci")
    end

    it "converts tens and teens with Romanian conjunctions" do
      expect(Num2words.to_words(10, :ro)).to eq("zece")
      expect(Num2words.to_words(11, :ro)).to eq("unsprezece")
      expect(Num2words.to_words(19, :ro)).to eq("nouăsprezece")
      expect(Num2words.to_words(20, :ro)).to eq("douăzeci")
      expect(Num2words.to_words(21, :ro)).to eq("douăzeci și unu")
      expect(Num2words.to_words(24, :ro)).to eq("douăzeci și patru")
      expect(Num2words.to_words(35, :ro)).to eq("treizeci și cinci")
      expect(Num2words.to_words(99, :ro)).to eq("nouăzeci și nouă")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :ro)).to eq("o sută")
      expect(Num2words.to_words(101, :ro)).to eq("o sută unu")
      expect(Num2words.to_words(105, :ro)).to eq("o sută cinci")
      expect(Num2words.to_words(124, :ro)).to eq("o sută douăzeci și patru")
      expect(Num2words.to_words(999, :ro)).to eq("nouă sute nouăzeci și nouă")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :ro)).to eq("o mie")
      expect(Num2words.to_words(2_000, :ro)).to eq("două mii")
      expect(Num2words.to_words(5_000, :ro)).to eq("cinci mii")
      expect(Num2words.to_words(21_000, :ro)).to eq("douăzeci și unu de mii")
      expect(Num2words.to_words(22_000, :ro)).to eq("douăzeci și doi de mii")
      expect(Num2words.to_words(1_001, :ro)).to eq("o mie unu")
      expect(Num2words.to_words(2_002, :ro)).to eq("două mii doi")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :ro)).to eq("un milion")
      expect(Num2words.to_words(2_000_000, :ro)).to eq("două milioane")
      expect(Num2words.to_words(21_000_000, :ro)).to eq("douăzeci și unu de milioane")
      expect(Num2words.to_words(1_234_567, :ro)).to eq(
        "un milion două sute treizeci și patru de mii cinci sute șaizeci și șapte"
      )
      expect(Num2words.to_words(9_876_543_210, :ro)).to eq(
        "nouă miliarde opt sute șaptezeci și șase de milioane cinci sute patruzeci și trei de mii două sute zece"
      )
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :ro, feminine: true)).to eq("una")
      expect(Num2words.to_words(2, :ro, feminine: true)).to eq("două")
      expect(Num2words.to_words(21, :ro, feminine: true)).to eq("douăzeci și una")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ro)).to eq("minus unu")
      expect(Num2words.to_words(-21, :ro)).to eq("minus douăzeci și unu")
      expect(Num2words.to_words("-42", :ro)).to eq("minus patruzeci și doi")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :ro)).to eq("trei întregi cinci zecimi")
      expect(Num2words.to_words("3,5", :ro)).to eq("trei întregi cinci zecimi")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ro)).to eq("zero întregi cinci zecimi")
      expect(Num2words.to_words(2.25, :ro)).to eq("doi întregi douăzeci și cinci sutimi")
      expect(Num2words.to_words(3.01, :ro)).to eq("trei întregi una sutime")
      expect(Num2words.to_words(-1.2, :ro)).to eq("minus unu întregi două zecimi")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :ro, joiner: :and)).to eq("zero și cinci zecimi")
      expect(Num2words.to_words(12.12, :ro, style: :decimal)).to eq("douăsprezece virgulă unu doi")
      expect(Num2words.to_words("3,05", :ro, style: :decimal)).to eq("trei virgulă zero cinci")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ro)).to eq("unu leu zero bani")
      expect(Num2words.to_currency(2, :ro)).to eq("doi lei zero bani")
      expect(Num2words.to_currency("12.50", :ro)).to eq("douăsprezece lei cincizeci bani")
      expect(Num2words.to_currency("1.01", :ro, code: :GBP)).to eq("una liră unu penny")
      expect(Num2words.to_currency("12.50", :ro, code: :BRL)).to eq("douăsprezece reali brazilieni cincizeci centavo")
      expect(Num2words.to_currency(12, :ro, minor: :nonzero)).to eq("douăsprezece lei")
      expect(Num2words.to_currency(12.5, :ro, minor: :never)).to eq("douăsprezece lei")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ro)).to eq("douăzeci și unu august două mii douăzeci și patru")
      expect(Num2words.to_words("14:35:42", :ro)).to eq("paisprezece ore treizeci și cinci minute patruzeci și două secunde")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ro)).to eq(
        "douăzeci și unu august două mii douăzeci și patru, paisprezece ore treizeci și cinci minute patruzeci și două secunde"
      )
    end
  end
end
