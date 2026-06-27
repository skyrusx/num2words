# frozen_string_literal: true

require "num2words"

RSpec.describe "Swedish locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :sv)).to eq("noll")
      expect(Num2words.to_words(1, :sv)).to eq("ett")
      expect(Num2words.to_words(2, :sv)).to eq("två")
      expect(Num2words.to_words(5, :sv)).to eq("fem")
    end

    it "converts Swedish-specific tens and teens" do
      expect(Num2words.to_words(10, :sv)).to eq("tio")
      expect(Num2words.to_words(11, :sv)).to eq("elva")
      expect(Num2words.to_words(19, :sv)).to eq("nitton")
      expect(Num2words.to_words(20, :sv)).to eq("tjugo")
      expect(Num2words.to_words(21, :sv)).to eq("tjugoett")
      expect(Num2words.to_words(24, :sv)).to eq("tjugofyra")
      expect(Num2words.to_words(35, :sv)).to eq("trettiofem")
      expect(Num2words.to_words(99, :sv)).to eq("nittionio")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :sv)).to eq("hundra")
      expect(Num2words.to_words(101, :sv)).to eq("hundra ett")
      expect(Num2words.to_words(105, :sv)).to eq("hundra fem")
      expect(Num2words.to_words(124, :sv)).to eq("hundra tjugofyra")
      expect(Num2words.to_words(999, :sv)).to eq("niohundra nittionio")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :sv)).to eq("ett tusen")
      expect(Num2words.to_words(2_000, :sv)).to eq("två tusen")
      expect(Num2words.to_words(5_000, :sv)).to eq("fem tusen")
      expect(Num2words.to_words(21_000, :sv)).to eq("tjugoett tusen")
      expect(Num2words.to_words(1_001, :sv)).to eq("ett tusen ett")
      expect(Num2words.to_words(2_002, :sv)).to eq("två tusen två")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :sv)).to eq("en miljon")
      expect(Num2words.to_words(2_000_000, :sv)).to eq("två miljoner")
      expect(Num2words.to_words(1_234_567, :sv)).to eq(
        "en miljon tvåhundra trettiofyra tusen femhundra sextiosju"
      )
      expect(Num2words.to_words(9_876_543_210, :sv)).to eq(
        "nio miljarder åttahundra sjuttiosex miljoner femhundra fyrtiotre tusen tvåhundra tio"
      )
    end
  end

  context "feminine option" do
    it "uses common-gender one where applicable" do
      expect(Num2words.to_words(1, :sv, feminine: true)).to eq("en")
      expect(Num2words.to_words(21, :sv, feminine: true)).to eq("tjugoen")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :sv)).to eq("minus ett")
      expect(Num2words.to_words(-21, :sv)).to eq("minus tjugoett")
      expect(Num2words.to_words("-42", :sv)).to eq("minus fyrtiotvå")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :sv)).to eq("tre komma fem tiondelar")
      expect(Num2words.to_words("3,5", :sv)).to eq("tre komma fem tiondelar")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :sv)).to eq("noll komma fem tiondelar")
      expect(Num2words.to_words(2.25, :sv)).to eq("två komma tjugofem hundradelar")
      expect(Num2words.to_words(3.01, :sv)).to eq("tre komma ett hundradel")
      expect(Num2words.to_words(-1.2, :sv)).to eq("minus ett komma två tiondelar")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :sv, joiner: :and)).to eq("noll och fem tiondelar")
      expect(Num2words.to_words(12.12, :sv, style: :decimal)).to eq("tolv komma ett två")
      expect(Num2words.to_words("3,05", :sv, style: :decimal)).to eq("tre komma noll fem")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :sv)).to eq("en krona noll öre")
      expect(Num2words.to_currency(2, :sv)).to eq("två kronor noll öre")
      expect(Num2words.to_currency("12.50", :sv)).to eq("tolv kronor femtio öre")
      expect(Num2words.to_currency("12.50", :sv, code: :BRL)).to eq("tolv brasilianska real femtio centavo")
      expect(Num2words.to_currency(12, :sv, minor: :nonzero)).to eq("tolv kronor")
      expect(Num2words.to_currency(12.5, :sv, minor: :never)).to eq("tolv kronor")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :sv)).to eq("tjugoförsta augusti två tusen tjugofyra")
      expect(Num2words.to_words("14:35:42", :sv)).to eq("fjorton timmar trettiofem minuter fyrtiotvå sekunder")
      expect(Num2words.to_words("2024-08-21 14:35:42", :sv)).to eq(
        "tjugoförsta augusti två tusen tjugofyra, fjorton timmar trettiofem minuter fyrtiotvå sekunder"
      )
    end
  end
end
