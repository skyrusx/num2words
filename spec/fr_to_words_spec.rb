# frozen_string_literal: true

require "num2words"

RSpec.describe "French locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :fr)).to eq("zéro")
      expect(Num2words.to_words(1, :fr)).to eq("un")
      expect(Num2words.to_words(2, :fr)).to eq("deux")
      expect(Num2words.to_words(5, :fr)).to eq("cinq")
    end

    it "converts tens, teens and French-specific 70..99" do
      expect(Num2words.to_words(10, :fr)).to eq("dix")
      expect(Num2words.to_words(11, :fr)).to eq("onze")
      expect(Num2words.to_words(19, :fr)).to eq("dix-neuf")
      expect(Num2words.to_words(20, :fr)).to eq("vingt")
      expect(Num2words.to_words(21, :fr)).to eq("vingt et un")
      expect(Num2words.to_words(24, :fr)).to eq("vingt quatre")
      expect(Num2words.to_words(35, :fr)).to eq("trente cinq")
      expect(Num2words.to_words(71, :fr)).to eq("soixante et onze")
      expect(Num2words.to_words(80, :fr)).to eq("quatre-vingts")
      expect(Num2words.to_words(81, :fr)).to eq("quatre-vingt un")
      expect(Num2words.to_words(91, :fr)).to eq("quatre-vingt onze")
      expect(Num2words.to_words(99, :fr)).to eq("quatre-vingt dix-neuf")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :fr)).to eq("cent")
      expect(Num2words.to_words(101, :fr)).to eq("cent un")
      expect(Num2words.to_words(105, :fr)).to eq("cent cinq")
      expect(Num2words.to_words(124, :fr)).to eq("cent vingt quatre")
      expect(Num2words.to_words(200, :fr)).to eq("deux cents")
      expect(Num2words.to_words(201, :fr)).to eq("deux cent un")
      expect(Num2words.to_words(999, :fr)).to eq("neuf cent quatre-vingt dix-neuf")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :fr)).to eq("mille")
      expect(Num2words.to_words(2_000, :fr)).to eq("deux mille")
      expect(Num2words.to_words(5_000, :fr)).to eq("cinq mille")
      expect(Num2words.to_words(21_000, :fr)).to eq("vingt et un mille")
      expect(Num2words.to_words(22_000, :fr)).to eq("vingt deux mille")
      expect(Num2words.to_words(25_000, :fr)).to eq("vingt cinq mille")
      expect(Num2words.to_words(1_001, :fr)).to eq("mille un")
      expect(Num2words.to_words(2_002, :fr)).to eq("deux mille deux")
      expect(Num2words.to_words(5_005, :fr)).to eq("cinq mille cinq")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :fr)).to eq("un million")
      expect(Num2words.to_words(2_000_000, :fr)).to eq("deux millions")
      expect(Num2words.to_words(5_000_000, :fr)).to eq("cinq millions")
      expect(Num2words.to_words(1_000_000_000, :fr)).to eq("un milliard")
      expect(Num2words.to_words(2_000_000_000, :fr)).to eq("deux milliards")
      expect(Num2words.to_words(5_000_000_000, :fr)).to eq("cinq milliards")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :fr)).to eq("un million deux cent trente quatre mille cinq cent soixante sept")
      expect(Num2words.to_words(1_000_001, :fr)).to eq("un million un")
      expect(Num2words.to_words(2_021_004, :fr)).to eq("deux millions vingt et un mille quatre")
    end
  end

  context "feminine option" do
    it "uses feminine form for one" do
      expect(Num2words.to_words(1, :fr, feminine: true)).to eq("une")
      expect(Num2words.to_words(2, :fr, feminine: true)).to eq("deux")
      expect(Num2words.to_words(21, :fr, feminine: true)).to eq("vingt et une")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :fr)).to eq("moins un")
      expect(Num2words.to_words(-21, :fr)).to eq("moins vingt et un")
      expect(Num2words.to_words(-1_000, :fr)).to eq("moins mille")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :fr)).to eq("sept")
      expect(Num2words.to_words("-42", :fr)).to eq("moins quarante deux")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :fr)).to eq("trois et cinq dixièmes")
      expect(Num2words.to_words("3,5", :fr)).to eq("trois et cinq dixièmes")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :fr)).to eq("zéro et cinq dixièmes")
      expect(Num2words.to_words(2.25, :fr)).to eq("deux et vingt cinq centièmes")
      expect(Num2words.to_words(3.01, :fr)).to eq("trois et un centième")
      expect(Num2words.to_words(-1.2, :fr)).to eq("moins un et deux dixièmes")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :fr)).to eq(
        "neuf milliards huit cent soixante seize millions cinq cent quarante trois mille deux cent dix"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :fr)).to eq("onze mille onze")
      expect(Num2words.to_words(1_011_011, :fr)).to eq("un million onze mille onze")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "vingt et un"
      expect(Num2words.to_words(21, :fr, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :fr, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :fr, word_case: :capitalize)).to eq("Vingt et un")
      expect(Num2words.to_words(21, :fr, word_case: :title)).to eq("Vingt Et Un")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :fr)).to eq("un euro zéro centimes")
      expect(Num2words.to_currency(2, :fr)).to eq("deux euros zéro centimes")
      expect(Num2words.to_currency("12.50", :fr)).to eq("douze euros cinquante centimes")
      expect(Num2words.to_currency(12, :fr, minor: :nonzero)).to eq("douze euros")
      expect(Num2words.to_currency(12.5, :fr, minor: :never)).to eq("douze euros")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-01", :fr)).to eq("premier août deux mille vingt quatre")
      expect(Num2words.to_words("2024-08-21", :fr)).to eq("vingt et un août deux mille vingt quatre")
      expect(Num2words.to_words("14:35:42", :fr)).to eq("quatorze heures trente cinq minutes quarante deux secondes")
      expect(Num2words.to_words("2024-08-21 14:35:42", :fr)).to eq(
        "vingt et un août deux mille vingt quatre, quatorze heures trente cinq minutes quarante deux secondes"
      )
    end
  end
end
