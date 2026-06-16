# frozen_string_literal: true

require "num2words"

RSpec.describe "Malayalam locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ml)).to eq("പൂജ്യം")
      expect(Num2words.to_words(1, :ml)).to eq("ഒന്ന്")
      expect(Num2words.to_words(2, :ml)).to eq("രണ്ട്")
      expect(Num2words.to_words(5, :ml)).to eq("അഞ്ച്")
    end

    it "converts Malayalam-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :ml)).to eq("പത്ത്")
      expect(Num2words.to_words(11, :ml)).to eq("പതിനൊന്ന്")
      expect(Num2words.to_words(19, :ml)).to eq("പത്തൊമ്പത്")
      expect(Num2words.to_words(20, :ml)).to eq("ഇരുപത്")
      expect(Num2words.to_words(21, :ml)).to eq("ഇരുപത്തൊന്ന്")
      expect(Num2words.to_words(24, :ml)).to eq("ഇരുപത്തിനാല്")
      expect(Num2words.to_words(35, :ml)).to eq("മുപ്പത്തിയഞ്ച്")
      expect(Num2words.to_words(99, :ml)).to eq("തൊണ്ണൂറ്റൊമ്പത്")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :ml)).to eq("നൂറ്")
      expect(Num2words.to_words(101, :ml)).to eq("നൂറ് ഒന്ന്")
      expect(Num2words.to_words(105, :ml)).to eq("നൂറ് അഞ്ച്")
      expect(Num2words.to_words(124, :ml)).to eq("നൂറ് ഇരുപത്തിനാല്")
      expect(Num2words.to_words(999, :ml)).to eq("തൊള്ളായിരം തൊണ്ണൂറ്റൊമ്പത്")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :ml)).to eq("ഒന്ന് ആയിരം")
      expect(Num2words.to_words(2_000, :ml)).to eq("രണ്ട് ആയിരം")
      expect(Num2words.to_words(5_000, :ml)).to eq("അഞ്ച് ആയിരം")
      expect(Num2words.to_words(21_000, :ml)).to eq("ഇരുപത്തൊന്ന് ആയിരം")
      expect(Num2words.to_words(22_000, :ml)).to eq("ഇരുപത്തിരണ്ട് ആയിരം")
      expect(Num2words.to_words(25_000, :ml)).to eq("ഇരുപത്തിയഞ്ച് ആയിരം")
      expect(Num2words.to_words(1_001, :ml)).to eq("ഒന്ന് ആയിരം ഒന്ന്")
      expect(Num2words.to_words(2_002, :ml)).to eq("രണ്ട് ആയിരം രണ്ട്")
      expect(Num2words.to_words(5_005, :ml)).to eq("അഞ്ച് ആയിരം അഞ്ച്")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :ml)).to eq("ഒന്ന് ലക്ഷം")
      expect(Num2words.to_words(2_000_000, :ml)).to eq("ഇരുപത് ലക്ഷം")
      expect(Num2words.to_words(10_000_000, :ml)).to eq("ഒന്ന് കോടി")
      expect(Num2words.to_words(1_000_000_000, :ml)).to eq("ഒന്ന് ശതകോടി")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :ml)).to eq("പന്ത്രണ്ട് ലക്ഷം മുപ്പത്തിനാല് ആയിരം അഞ്ഞൂറ് അറുപത്തിയേഴ്")
      expect(Num2words.to_words(1_000_001, :ml)).to eq("പത്ത് ലക്ഷം ഒന്ന്")
      expect(Num2words.to_words(2_021_004, :ml)).to eq("ഇരുപത് ലക്ഷം ഇരുപത്തൊന്ന് ആയിരം നാല്")
    end
  end

  context "feminine option" do
    it "does not change Malayalam output" do
      expect(Num2words.to_words(1, :ml, feminine: true)).to eq("ഒന്ന്")
      expect(Num2words.to_words(2, :ml, feminine: true)).to eq("രണ്ട്")
      expect(Num2words.to_words(21, :ml, feminine: true)).to eq("ഇരുപത്തൊന്ന്")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ml)).to eq("മൈനസ് ഒന്ന്")
      expect(Num2words.to_words(-21, :ml)).to eq("മൈനസ് ഇരുപത്തൊന്ന്")
      expect(Num2words.to_words(-1_000, :ml)).to eq("മൈനസ് ഒന്ന് ആയിരം")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :ml)).to eq("ഏഴ്")
      expect(Num2words.to_words("-42", :ml)).to eq("മൈനസ് നാല്പത്തിരണ്ട്")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :ml)).to eq("മൂന്ന് പൂർണ്ണം അഞ്ച് പത്തിലൊന്ന്")
      expect(Num2words.to_words("3,5", :ml)).to eq("മൂന്ന് പൂർണ്ണം അഞ്ച് പത്തിലൊന്ന്")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ml)).to eq("പൂജ്യം പൂർണ്ണം അഞ്ച് പത്തിലൊന്ന്")
      expect(Num2words.to_words(2.25, :ml)).to eq("രണ്ട് പൂർണ്ണം ഇരുപത്തിയഞ്ച് നൂറിലൊന്ന്")
      expect(Num2words.to_words(3.01, :ml)).to eq("മൂന്ന് പൂർണ്ണം ഒന്ന് നൂറിലൊന്ന്")
      expect(Num2words.to_words(-1.2, :ml)).to eq("മൈനസ് ഒന്ന് പൂർണ്ണം രണ്ട് പത്തിലൊന്ന്")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :ml, joiner: :and)).to eq("പൂജ്യം കൂടാതെ അഞ്ച് പത്തിലൊന്ന്")
      expect(Num2words.to_words(12.12, :ml, style: :decimal)).to eq("പന്ത്രണ്ട് ദശാംശം ഒന്ന് രണ്ട്")
      expect(Num2words.to_words("3,05", :ml, style: :decimal)).to eq("മൂന്ന് ദശാംശം പൂജ്യം അഞ്ച്")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :ml)).to eq(
        "ഒമ്പത് ശതകോടി എൺപത്തിയേഴ് കോടി അറുപത്തിയഞ്ച് ലക്ഷം നാല്പത്തിമൂന്ന് ആയിരം ഇരുനൂറ് പത്ത്"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :ml)).to eq("പതിനൊന്ന് ആയിരം പതിനൊന്ന്")
      expect(Num2words.to_words(1_011_011, :ml)).to eq("പത്ത് ലക്ഷം പതിനൊന്ന് ആയിരം പതിനൊന്ന്")
    end
  end

  context "word case" do
    it "applies case options without changing Malayalam text" do
      base = "ഇരുപത്തൊന്ന്"
      expect(Num2words.to_words(21, :ml, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :ml, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :ml, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :ml, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ml)).to eq("ഒന്ന് രൂപ പൂജ്യം പൈസ")
      expect(Num2words.to_currency(2, :ml)).to eq("രണ്ട് രൂപ പൂജ്യം പൈസ")
      expect(Num2words.to_currency("12.50", :ml)).to eq("പന്ത്രണ്ട് രൂപ അമ്പത് പൈസ")
      expect(Num2words.to_currency("12.50", :ml, code: :BRL)).to eq("പന്ത്രണ്ട് ബ്രസീലിയൻ റിയാൽ അമ്പത് സെന്റാവോ")
      expect(Num2words.to_currency(12, :ml, minor: :nonzero)).to eq("പന്ത്രണ്ട് രൂപ")
      expect(Num2words.to_currency(12.5, :ml, minor: :never)).to eq("പന്ത്രണ്ട് രൂപ")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ml)).to eq("ഇരുപത്തൊന്നാം ഓഗസ്റ്റ് രണ്ട് ആയിരം ഇരുപത്തിനാല്")
      expect(Num2words.to_words("14:35:42", :ml)).to eq("പതിനാല് മണിക്കൂർ മുപ്പത്തിയഞ്ച് മിനിറ്റ് നാല്പത്തിരണ്ട് സെക്കൻഡ്")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ml)).to eq(
        "ഇരുപത്തൊന്നാം ഓഗസ്റ്റ് രണ്ട് ആയിരം ഇരുപത്തിനാല്, പതിനാല് മണിക്കൂർ മുപ്പത്തിയഞ്ച് മിനിറ്റ് നാല്പത്തിരണ്ട് സെക്കൻഡ്"
      )
    end
  end
end
