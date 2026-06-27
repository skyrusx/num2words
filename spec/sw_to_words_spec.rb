# frozen_string_literal: true

require "num2words"

RSpec.describe "Swahili locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :sw)).to eq("sifuri")
      expect(Num2words.to_words(1, :sw)).to eq("moja")
      expect(Num2words.to_words(2, :sw)).to eq("mbili")
      expect(Num2words.to_words(5, :sw)).to eq("tano")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :sw)).to eq("kumi")
      expect(Num2words.to_words(11, :sw)).to eq("kumi na moja")
      expect(Num2words.to_words(19, :sw)).to eq("kumi na tisa")
      expect(Num2words.to_words(20, :sw)).to eq("ishirini")
      expect(Num2words.to_words(21, :sw)).to eq("ishirini na moja")
      expect(Num2words.to_words(24, :sw)).to eq("ishirini na nne")
      expect(Num2words.to_words(35, :sw)).to eq("thelathini na tano")
      expect(Num2words.to_words(99, :sw)).to eq("tisini na tisa")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :sw)).to eq("mia moja")
      expect(Num2words.to_words(101, :sw)).to eq("mia moja na moja")
      expect(Num2words.to_words(105, :sw)).to eq("mia moja na tano")
      expect(Num2words.to_words(124, :sw)).to eq("mia moja na ishirini na nne")
      expect(Num2words.to_words(999, :sw)).to eq("mia tisa na tisini na tisa")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :sw)).to eq("moja elfu")
      expect(Num2words.to_words(2_000, :sw)).to eq("mbili elfu")
      expect(Num2words.to_words(5_000, :sw)).to eq("tano elfu")
      expect(Num2words.to_words(21_000, :sw)).to eq("ishirini na moja elfu")
      expect(Num2words.to_words(1_001, :sw)).to eq("moja elfu moja")
      expect(Num2words.to_words(2_002, :sw)).to eq("mbili elfu mbili")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :sw)).to eq("moja milioni")
      expect(Num2words.to_words(2_000_000, :sw)).to eq("mbili milioni")
      expect(Num2words.to_words(1_234_567, :sw)).to eq(
        "moja milioni mia mbili na thelathini na nne elfu mia tano na sitini na saba"
      )
      expect(Num2words.to_words(9_876_543_210, :sw)).to eq(
        "tisa bilioni mia nane na sabini na sita milioni mia tano na arobaini na tatu elfu mia mbili na kumi"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :sw)).to eq("minus moja")
      expect(Num2words.to_words(-21, :sw)).to eq("minus ishirini na moja")
      expect(Num2words.to_words("-42", :sw)).to eq("minus arobaini na mbili")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :sw)).to eq("tatu koma tano sehemu ya kumi")
      expect(Num2words.to_words("3,5", :sw)).to eq("tatu koma tano sehemu ya kumi")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :sw)).to eq("sifuri koma tano sehemu ya kumi")
      expect(Num2words.to_words(2.25, :sw)).to eq("mbili koma ishirini na tano sehemu ya mia")
      expect(Num2words.to_words(3.01, :sw)).to eq("tatu koma moja sehemu ya mia")
      expect(Num2words.to_words(-1.2, :sw)).to eq("minus moja koma mbili sehemu ya kumi")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :sw, joiner: :and)).to eq("sifuri na tano sehemu ya kumi")
      expect(Num2words.to_words(12.12, :sw, style: :decimal)).to eq("kumi na mbili koma moja mbili")
      expect(Num2words.to_words("3,05", :sw, style: :decimal)).to eq("tatu koma sifuri tano")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :sw)).to eq("moja shilingi sifuri senti")
      expect(Num2words.to_currency(2, :sw)).to eq("mbili shilingi sifuri senti")
      expect(Num2words.to_currency("12.50", :sw)).to eq("kumi na mbili shilingi hamsini senti")
      expect(Num2words.to_currency("12.50", :sw, code: :BRL)).to eq("kumi na mbili reali ya brazili hamsini sentavo")
      expect(Num2words.to_currency(12, :sw, minor: :nonzero)).to eq("kumi na mbili shilingi")
      expect(Num2words.to_currency(12.5, :sw, minor: :never)).to eq("kumi na mbili shilingi")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :sw)).to eq("ishirini na moja Agosti mbili elfu ishirini na nne")
      expect(Num2words.to_words("14:35:42", :sw)).to eq("kumi na nne saa thelathini na tano dakika arobaini na mbili sekunde")
      expect(Num2words.to_words("2024-08-21 14:35:42", :sw)).to eq(
        "ishirini na moja Agosti mbili elfu ishirini na nne, kumi na nne saa thelathini na tano dakika arobaini na mbili sekunde"
      )
    end
  end
end
