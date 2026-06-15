# frozen_string_literal: true

require "num2words"

RSpec.describe "Italian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :it)).to eq("zero")
      expect(Num2words.to_words(1, :it)).to eq("uno")
      expect(Num2words.to_words(2, :it)).to eq("due")
      expect(Num2words.to_words(5, :it)).to eq("cinque")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :it)).to eq("dieci")
      expect(Num2words.to_words(11, :it)).to eq("undici")
      expect(Num2words.to_words(19, :it)).to eq("diciannove")
      expect(Num2words.to_words(20, :it)).to eq("venti")
      expect(Num2words.to_words(21, :it)).to eq("ventuno")
      expect(Num2words.to_words(24, :it)).to eq("ventiquattro")
      expect(Num2words.to_words(28, :it)).to eq("ventotto")
      expect(Num2words.to_words(35, :it)).to eq("trentacinque")
      expect(Num2words.to_words(99, :it)).to eq("novantanove")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :it)).to eq("cento")
      expect(Num2words.to_words(101, :it)).to eq("centouno")
      expect(Num2words.to_words(105, :it)).to eq("centocinque")
      expect(Num2words.to_words(124, :it)).to eq("centoventiquattro")
      expect(Num2words.to_words(180, :it)).to eq("centottanta")
      expect(Num2words.to_words(999, :it)).to eq("novecentonovantanove")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :it)).to eq("mille")
      expect(Num2words.to_words(2_000, :it)).to eq("due mila")
      expect(Num2words.to_words(5_000, :it)).to eq("cinque mila")
      expect(Num2words.to_words(21_000, :it)).to eq("ventuno mila")
      expect(Num2words.to_words(22_000, :it)).to eq("ventidue mila")
      expect(Num2words.to_words(25_000, :it)).to eq("venticinque mila")
      expect(Num2words.to_words(1_001, :it)).to eq("mille uno")
      expect(Num2words.to_words(2_002, :it)).to eq("due mila due")
      expect(Num2words.to_words(5_005, :it)).to eq("cinque mila cinque")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :it)).to eq("un milione")
      expect(Num2words.to_words(2_000_000, :it)).to eq("due milioni")
      expect(Num2words.to_words(5_000_000, :it)).to eq("cinque milioni")
      expect(Num2words.to_words(1_000_000_000, :it)).to eq("un miliardo")
      expect(Num2words.to_words(2_000_000_000, :it)).to eq("due miliardi")
      expect(Num2words.to_words(5_000_000_000, :it)).to eq("cinque miliardi")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :it)).to eq("un milione duecentotrentaquattro mila cinquecentosessantasette")
      expect(Num2words.to_words(1_000_001, :it)).to eq("un milione uno")
      expect(Num2words.to_words(2_021_004, :it)).to eq("due milioni ventuno mila quattro")
    end
  end

  context "feminine option" do
    it "uses feminine form for one" do
      expect(Num2words.to_words(1, :it, feminine: true)).to eq("una")
      expect(Num2words.to_words(2, :it, feminine: true)).to eq("due")
      expect(Num2words.to_words(21, :it, feminine: true)).to eq("ventuna")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :it)).to eq("meno uno")
      expect(Num2words.to_words(-21, :it)).to eq("meno ventuno")
      expect(Num2words.to_words(-1_000, :it)).to eq("meno mille")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :it)).to eq("sette")
      expect(Num2words.to_words("-42", :it)).to eq("meno quarantadue")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :it)).to eq("tre virgola cinque decimi")
      expect(Num2words.to_words("3,5", :it)).to eq("tre virgola cinque decimi")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :it)).to eq("zero virgola cinque decimi")
      expect(Num2words.to_words(2.25, :it)).to eq("due virgola venticinque centesimi")
      expect(Num2words.to_words(3.01, :it)).to eq("tre virgola uno centesimo")
      expect(Num2words.to_words(-1.2, :it)).to eq("meno uno virgola due decimi")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :it, joiner: :and)).to eq("zero e cinque decimi")
      expect(Num2words.to_words(12.12, :it, style: :decimal)).to eq("dodici virgola uno due")
      expect(Num2words.to_words("3,05", :it, style: :decimal)).to eq("tre virgola zero cinque")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :it)).to eq(
        "nove miliardi ottocentosettantasei milioni cinquecentoquarantatre mila duecentodieci"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :it)).to eq("undici mila undici")
      expect(Num2words.to_words(1_011_011, :it)).to eq("un milione undici mila undici")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "ventuno"
      expect(Num2words.to_words(21, :it, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :it, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :it, word_case: :capitalize)).to eq("Ventuno")
      expect(Num2words.to_words(21, :it, word_case: :title)).to eq("Ventuno")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :it)).to eq("uno euro zero centesimi")
      expect(Num2words.to_currency(2, :it)).to eq("due euro zero centesimi")
      expect(Num2words.to_currency("12.50", :it)).to eq("dodici euro cinquanta centesimi")
      expect(Num2words.to_currency("1.01", :it, code: :GBP)).to eq("una sterlina uno penny")
      expect(Num2words.to_currency("12.50", :it, code: :BRL)).to eq("dodici real brasiliani cinquanta centavos")
      expect(Num2words.to_currency(12, :it, minor: :nonzero)).to eq("dodici euro")
      expect(Num2words.to_currency(12.5, :it, minor: :never)).to eq("dodici euro")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :it)).to eq("ventuno agosto due mila ventiquattro")
      expect(Num2words.to_words("14:35:42", :it)).to eq("quattordici ore trentacinque minuti quarantadue secondi")
      expect(Num2words.to_words("2024-08-21 14:35:42", :it)).to eq(
        "ventuno agosto due mila ventiquattro, quattordici ore trentacinque minuti quarantadue secondi"
      )
    end
  end
end
