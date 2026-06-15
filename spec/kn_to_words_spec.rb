# frozen_string_literal: true

require "num2words"

RSpec.describe "Kannada locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :kn)).to eq("ಸೊನ್ನೆ")
      expect(Num2words.to_words(1, :kn)).to eq("ಒಂದು")
      expect(Num2words.to_words(2, :kn)).to eq("ಎರಡು")
      expect(Num2words.to_words(5, :kn)).to eq("ಐದು")
    end

    it "converts Kannada-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :kn)).to eq("ಹತ್ತು")
      expect(Num2words.to_words(11, :kn)).to eq("ಹನ್ನೊಂದು")
      expect(Num2words.to_words(19, :kn)).to eq("ಹತ್ತೊಂಬತ್ತು")
      expect(Num2words.to_words(20, :kn)).to eq("ಇಪ್ಪತ್ತು")
      expect(Num2words.to_words(21, :kn)).to eq("ಇಪ್ಪತ್ತೊಂದು")
      expect(Num2words.to_words(24, :kn)).to eq("ಇಪ್ಪತ್ತನಾಲ್ಕು")
      expect(Num2words.to_words(35, :kn)).to eq("ಮೂವತ್ತೈದು")
      expect(Num2words.to_words(99, :kn)).to eq("ತೊಂಬತ್ತೊಂಬತ್ತು")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :kn)).to eq("ನೂರು")
      expect(Num2words.to_words(101, :kn)).to eq("ನೂರು ಒಂದು")
      expect(Num2words.to_words(105, :kn)).to eq("ನೂರು ಐದು")
      expect(Num2words.to_words(124, :kn)).to eq("ನೂರು ಇಪ್ಪತ್ತನಾಲ್ಕು")
      expect(Num2words.to_words(999, :kn)).to eq("ಒಂಬತ್ತು ನೂರು ತೊಂಬತ್ತೊಂಬತ್ತು")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :kn)).to eq("ಒಂದು ಸಾವಿರ")
      expect(Num2words.to_words(2_000, :kn)).to eq("ಎರಡು ಸಾವಿರ")
      expect(Num2words.to_words(5_000, :kn)).to eq("ಐದು ಸಾವಿರ")
      expect(Num2words.to_words(21_000, :kn)).to eq("ಇಪ್ಪತ್ತೊಂದು ಸಾವಿರ")
      expect(Num2words.to_words(22_000, :kn)).to eq("ಇಪ್ಪತ್ತೆರಡು ಸಾವಿರ")
      expect(Num2words.to_words(25_000, :kn)).to eq("ಇಪ್ಪತ್ತೈದು ಸಾವಿರ")
      expect(Num2words.to_words(1_001, :kn)).to eq("ಒಂದು ಸಾವಿರ ಒಂದು")
      expect(Num2words.to_words(2_002, :kn)).to eq("ಎರಡು ಸಾವಿರ ಎರಡು")
      expect(Num2words.to_words(5_005, :kn)).to eq("ಐದು ಸಾವಿರ ಐದು")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :kn)).to eq("ಒಂದು ಲಕ್ಷ")
      expect(Num2words.to_words(2_000_000, :kn)).to eq("ಇಪ್ಪತ್ತು ಲಕ್ಷ")
      expect(Num2words.to_words(10_000_000, :kn)).to eq("ಒಂದು ಕೋಟಿ")
      expect(Num2words.to_words(1_000_000_000, :kn)).to eq("ಒಂದು ಅರಬ್")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :kn)).to eq("ಹನ್ನೆರಡು ಲಕ್ಷ ಮೂವತ್ತನಾಲ್ಕು ಸಾವಿರ ಐದು ನೂರು ಅರವತ್ತೇಳು")
      expect(Num2words.to_words(1_000_001, :kn)).to eq("ಹತ್ತು ಲಕ್ಷ ಒಂದು")
      expect(Num2words.to_words(2_021_004, :kn)).to eq("ಇಪ್ಪತ್ತು ಲಕ್ಷ ಇಪ್ಪತ್ತೊಂದು ಸಾವಿರ ನಾಲ್ಕು")
    end
  end

  context "feminine option" do
    it "does not change Kannada output" do
      expect(Num2words.to_words(1, :kn, feminine: true)).to eq("ಒಂದು")
      expect(Num2words.to_words(2, :kn, feminine: true)).to eq("ಎರಡು")
      expect(Num2words.to_words(21, :kn, feminine: true)).to eq("ಇಪ್ಪತ್ತೊಂದು")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :kn)).to eq("ಮೈನಸ್ ಒಂದು")
      expect(Num2words.to_words(-21, :kn)).to eq("ಮೈನಸ್ ಇಪ್ಪತ್ತೊಂದು")
      expect(Num2words.to_words(-1_000, :kn)).to eq("ಮೈನಸ್ ಒಂದು ಸಾವಿರ")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :kn)).to eq("ಏಳು")
      expect(Num2words.to_words("-42", :kn)).to eq("ಮೈನಸ್ ನಲವತ್ತೆರಡು")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :kn)).to eq("ಮೂರು ಪೂರ್ಣ ಐದು ಹತ್ತನೇ")
      expect(Num2words.to_words("3,5", :kn)).to eq("ಮೂರು ಪೂರ್ಣ ಐದು ಹತ್ತನೇ")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :kn)).to eq("ಸೊನ್ನೆ ಪೂರ್ಣ ಐದು ಹತ್ತನೇ")
      expect(Num2words.to_words(2.25, :kn)).to eq("ಎರಡು ಪೂರ್ಣ ಇಪ್ಪತ್ತೈದು ನೂರನೇ")
      expect(Num2words.to_words(3.01, :kn)).to eq("ಮೂರು ಪೂರ್ಣ ಒಂದು ನೂರನೇ")
      expect(Num2words.to_words(-1.2, :kn)).to eq("ಮೈನಸ್ ಒಂದು ಪೂರ್ಣ ಎರಡು ಹತ್ತನೇ")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :kn, joiner: :and)).to eq("ಸೊನ್ನೆ ಮತ್ತು ಐದು ಹತ್ತನೇ")
      expect(Num2words.to_words(12.12, :kn, style: :decimal)).to eq("ಹನ್ನೆರಡು ದಶಮಾಂಶ ಒಂದು ಎರಡು")
      expect(Num2words.to_words("3,05", :kn, style: :decimal)).to eq("ಮೂರು ದಶಮಾಂಶ ಸೊನ್ನೆ ಐದು")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :kn)).to eq(
        "ಒಂಬತ್ತು ಅರಬ್ ಎಂಬತ್ತೇಳು ಕೋಟಿ ಅರವತ್ತೈದು ಲಕ್ಷ ನಲವತ್ತಮೂರು ಸಾವಿರ ಎರಡು ನೂರು ಹತ್ತು"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :kn)).to eq("ಹನ್ನೊಂದು ಸಾವಿರ ಹನ್ನೊಂದು")
      expect(Num2words.to_words(1_011_011, :kn)).to eq("ಹತ್ತು ಲಕ್ಷ ಹನ್ನೊಂದು ಸಾವಿರ ಹನ್ನೊಂದು")
    end
  end

  context "word case" do
    it "applies case options without changing Kannada text" do
      base = "ಇಪ್ಪತ್ತೊಂದು"
      expect(Num2words.to_words(21, :kn, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :kn, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :kn, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :kn, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :kn)).to eq("ಒಂದು ರೂಪಾಯಿ ಸೊನ್ನೆ ಪೈಸೆಗಳು")
      expect(Num2words.to_currency(2, :kn)).to eq("ಎರಡು ರೂಪಾಯಿಗಳು ಸೊನ್ನೆ ಪೈಸೆಗಳು")
      expect(Num2words.to_currency("12.50", :kn)).to eq("ಹನ್ನೆರಡು ರೂಪಾಯಿಗಳು ಐವತ್ತು ಪೈಸೆಗಳು")
      expect(Num2words.to_currency("12.50", :kn, code: :BRL)).to eq("ಹನ್ನೆರಡು ಬ್ರೆಜಿಲಿಯನ್ ರಿಯಲ್ ಐವತ್ತು ಸೆಂಟಾವೊ")
      expect(Num2words.to_currency(12, :kn, minor: :nonzero)).to eq("ಹನ್ನೆರಡು ರೂಪಾಯಿಗಳು")
      expect(Num2words.to_currency(12.5, :kn, minor: :never)).to eq("ಹನ್ನೆರಡು ರೂಪಾಯಿಗಳು")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :kn)).to eq("ಇಪ್ಪತ್ತೊಂದನೇ ಆಗಸ್ಟ್ ಎರಡು ಸಾವಿರ ಇಪ್ಪತ್ತನಾಲ್ಕು")
      expect(Num2words.to_words("14:35:42", :kn)).to eq("ಹದಿನಾಲ್ಕು ಗಂಟೆಗಳು ಮೂವತ್ತೈದು ನಿಮಿಷಗಳು ನಲವತ್ತೆರಡು ಸೆಕೆಂಡ್‌ಗಳು")
      expect(Num2words.to_words("2024-08-21 14:35:42", :kn)).to eq(
        "ಇಪ್ಪತ್ತೊಂದನೇ ಆಗಸ್ಟ್ ಎರಡು ಸಾವಿರ ಇಪ್ಪತ್ತನಾಲ್ಕು, ಹದಿನಾಲ್ಕು ಗಂಟೆಗಳು ಮೂವತ್ತೈದು ನಿಮಿಷಗಳು ನಲವತ್ತೆರಡು ಸೆಕೆಂಡ್‌ಗಳು"
      )
    end
  end
end
