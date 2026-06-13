# frozen_string_literal: true

require "num2words"

RSpec.describe "English locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :en)).to eq("zero")
      expect(Num2words.to_words(1, :en)).to eq("one")
      expect(Num2words.to_words(2, :en)).to eq("two")
      expect(Num2words.to_words(5, :en)).to eq("five")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :en)).to eq("ten")
      expect(Num2words.to_words(11, :en)).to eq("eleven")
      expect(Num2words.to_words(19, :en)).to eq("nineteen")
      expect(Num2words.to_words(20, :en)).to eq("twenty")
      expect(Num2words.to_words(21, :en)).to eq("twenty one")
      expect(Num2words.to_words(24, :en)).to eq("twenty four")
      expect(Num2words.to_words(35, :en)).to eq("thirty five")
      expect(Num2words.to_words(99, :en)).to eq("ninety nine")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :en)).to eq("one hundred")
      expect(Num2words.to_words(101, :en)).to eq("one hundred one")
      expect(Num2words.to_words(105, :en)).to eq("one hundred five")
      expect(Num2words.to_words(124, :en)).to eq("one hundred twenty four")
      expect(Num2words.to_words(999, :en)).to eq("nine hundred ninety nine")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :en)).to eq("one thousand")
      expect(Num2words.to_words(2_000, :en)).to eq("two thousand")
      expect(Num2words.to_words(5_000, :en)).to eq("five thousand")
      expect(Num2words.to_words(21_000, :en)).to eq("twenty one thousand")
      expect(Num2words.to_words(22_000, :en)).to eq("twenty two thousand")
      expect(Num2words.to_words(25_000, :en)).to eq("twenty five thousand")
      expect(Num2words.to_words(1_001, :en)).to eq("one thousand one")
      expect(Num2words.to_words(2_002, :en)).to eq("two thousand two")
      expect(Num2words.to_words(5_005, :en)).to eq("five thousand five")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :en)).to eq("one million")
      expect(Num2words.to_words(2_000_000, :en)).to eq("two million")
      expect(Num2words.to_words(5_000_000, :en)).to eq("five million")
      expect(Num2words.to_words(1_000_000_000, :en)).to eq("one billion")
      expect(Num2words.to_words(2_000_000_000, :en)).to eq("two billion")
      expect(Num2words.to_words(5_000_000_000, :en)).to eq("five billion")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :en)).to eq("one million two hundred thirty four thousand five hundred sixty seven")
      expect(Num2words.to_words(1_000_001, :en)).to eq("one million one")
      expect(Num2words.to_words(2_021_004, :en)).to eq("two million twenty one thousand four")
    end
  end

  context "feminine option" do
    it "does not change English output" do
      expect(Num2words.to_words(1, :en, feminine: true)).to eq("one")
      expect(Num2words.to_words(2, :en, feminine: true)).to eq("two")
      expect(Num2words.to_words(21, :en, feminine: true)).to eq("twenty one")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :en)).to eq("minus one")
      expect(Num2words.to_words(-21, :en)).to eq("minus twenty one")
      expect(Num2words.to_words(-1_000, :en)).to eq("minus one thousand")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :en)).to eq("seven")
      expect(Num2words.to_words("-42", :en)).to eq("minus forty two")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :en)).to eq("three and five tenths")
      expect(Num2words.to_words("3,5", :en)).to eq("three and five tenths")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :en)).to eq("zero and five tenths")
      expect(Num2words.to_words(2.25, :en)).to eq("two and twenty five hundredths")
      expect(Num2words.to_words(3.01, :en)).to eq("three and one hundredth")
      expect(Num2words.to_words(-1.2, :en)).to eq("minus one and two tenths")
      expect(Num2words.to_words(2.21, :en)).to eq("two and twenty one hundredths")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :en, style: :decimal)).to eq("twelve point one two")
      expect(Num2words.to_words("3,05", :en, style: :decimal)).to eq("three point zero five")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :en)).to eq(
        "nine billion eight hundred seventy six million five hundred forty three thousand two hundred ten"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :en)).to eq("eleven thousand eleven")
      expect(Num2words.to_words(1_011_011, :en)).to eq("one million eleven thousand eleven")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "twenty one"
      expect(Num2words.to_words(21, :en, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :en, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :en, word_case: :capitalize)).to eq("Twenty one")
      expect(Num2words.to_words(21, :en, word_case: :title)).to eq("Twenty One")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :en)).to eq("one dollar zero cents")
      expect(Num2words.to_currency(2, :en)).to eq("two dollars zero cents")
      expect(Num2words.to_currency("12.50", :en)).to eq("twelve dollars fifty cents")
      expect(Num2words.to_currency("21.21", :en)).to eq("twenty one dollars twenty one cents")
      expect(Num2words.to_currency(12, :en, minor: :nonzero)).to eq("twelve dollars")
      expect(Num2words.to_currency(12.5, :en, minor: :never)).to eq("twelve dollars")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :en)).to eq("the twenty-first of August, two thousand twenty four")
      expect(Num2words.to_words("14:35:42", :en)).to eq("fourteen hours thirty five minutes forty two seconds")
      expect(Num2words.to_words("21:21:21", :en)).to eq("twenty one hours twenty one minutes twenty one seconds")
      expect(Num2words.to_words("2024-08-21 14:35:42", :en)).to eq(
        "the twenty-first of August, two thousand twenty four at fourteen hours thirty five minutes forty two seconds"
      )
    end
  end
end
