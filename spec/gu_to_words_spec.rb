# frozen_string_literal: true

require "num2words"

RSpec.describe "Gujarati locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :gu)).to eq("શૂન્ય")
      expect(Num2words.to_words(1, :gu)).to eq("એક")
      expect(Num2words.to_words(2, :gu)).to eq("બે")
      expect(Num2words.to_words(5, :gu)).to eq("પાંચ")
    end

    it "converts tens and Gujarati-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :gu)).to eq("દસ")
      expect(Num2words.to_words(11, :gu)).to eq("અગિયાર")
      expect(Num2words.to_words(19, :gu)).to eq("ઓગણીસ")
      expect(Num2words.to_words(20, :gu)).to eq("વીસ")
      expect(Num2words.to_words(21, :gu)).to eq("એકવીસ")
      expect(Num2words.to_words(24, :gu)).to eq("ચોવીસ")
      expect(Num2words.to_words(35, :gu)).to eq("પાંત્રીસ")
      expect(Num2words.to_words(99, :gu)).to eq("નવ્વાણું")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :gu)).to eq("સો")
      expect(Num2words.to_words(101, :gu)).to eq("સો એક")
      expect(Num2words.to_words(105, :gu)).to eq("સો પાંચ")
      expect(Num2words.to_words(124, :gu)).to eq("સો ચોવીસ")
      expect(Num2words.to_words(999, :gu)).to eq("નવસો નવ્વાણું")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :gu)).to eq("એક હજાર")
      expect(Num2words.to_words(2_000, :gu)).to eq("બે હજાર")
      expect(Num2words.to_words(5_000, :gu)).to eq("પાંચ હજાર")
      expect(Num2words.to_words(21_000, :gu)).to eq("એકવીસ હજાર")
      expect(Num2words.to_words(22_000, :gu)).to eq("બાવીસ હજાર")
      expect(Num2words.to_words(25_000, :gu)).to eq("પચ્ચીસ હજાર")
      expect(Num2words.to_words(1_001, :gu)).to eq("એક હજાર એક")
      expect(Num2words.to_words(2_002, :gu)).to eq("બે હજાર બે")
      expect(Num2words.to_words(5_005, :gu)).to eq("પાંચ હજાર પાંચ")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :gu)).to eq("એક લાખ")
      expect(Num2words.to_words(2_000_000, :gu)).to eq("વીસ લાખ")
      expect(Num2words.to_words(10_000_000, :gu)).to eq("એક કરોડ")
      expect(Num2words.to_words(1_000_000_000, :gu)).to eq("એક અબજ")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :gu)).to eq("બાર લાખ ચોત્રીસ હજાર પાંચસો સડસઠ")
      expect(Num2words.to_words(1_000_001, :gu)).to eq("દસ લાખ એક")
      expect(Num2words.to_words(2_021_004, :gu)).to eq("વીસ લાખ એકવીસ હજાર ચાર")
    end
  end

  context "feminine option" do
    it "does not change Gujarati output" do
      expect(Num2words.to_words(1, :gu, feminine: true)).to eq("એક")
      expect(Num2words.to_words(2, :gu, feminine: true)).to eq("બે")
      expect(Num2words.to_words(21, :gu, feminine: true)).to eq("એકવીસ")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :gu)).to eq("ઋણ એક")
      expect(Num2words.to_words(-21, :gu)).to eq("ઋણ એકવીસ")
      expect(Num2words.to_words(-1_000, :gu)).to eq("ઋણ એક હજાર")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :gu)).to eq("સાત")
      expect(Num2words.to_words("-42", :gu)).to eq("ઋણ બેતાલીસ")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :gu)).to eq("ત્રણ અને પાંચ દશમા")
      expect(Num2words.to_words("3,5", :gu)).to eq("ત્રણ અને પાંચ દશમા")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :gu)).to eq("શૂન્ય અને પાંચ દશમા")
      expect(Num2words.to_words(2.25, :gu)).to eq("બે અને પચ્ચીસ સોમા")
      expect(Num2words.to_words(3.01, :gu)).to eq("ત્રણ અને એક સોમો")
      expect(Num2words.to_words(-1.2, :gu)).to eq("ઋણ એક અને બે દશમા")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :gu, style: :decimal)).to eq("બાર દશાંશ એક બે")
      expect(Num2words.to_words("3,05", :gu, style: :decimal)).to eq("ત્રણ દશાંશ શૂન્ય પાંચ")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :gu)).to eq(
        "નવ અબજ સિત્યાસી કરોડ પાંસઠ લાખ ત્રેતાલીસ હજાર બસો દસ"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :gu)).to eq("અગિયાર હજાર અગિયાર")
      expect(Num2words.to_words(1_011_011, :gu)).to eq("દસ લાખ અગિયાર હજાર અગિયાર")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title without changing Gujarati text" do
      base = "એકવીસ"
      expect(Num2words.to_words(21, :gu, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :gu, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :gu, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :gu, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :gu)).to eq("એક રૂપિયો શૂન્ય પૈસા")
      expect(Num2words.to_currency(2, :gu)).to eq("બે રૂપિયા શૂન્ય પૈસા")
      expect(Num2words.to_currency("12.50", :gu)).to eq("બાર રૂપિયા પચાસ પૈસા")
      expect(Num2words.to_currency("12.50", :gu, code: :BRL)).to eq("બાર બ્રાઝિલિયન રીઅલ પચાસ સેન્ટાવો")
      expect(Num2words.to_currency(12, :gu, minor: :nonzero)).to eq("બાર રૂપિયા")
      expect(Num2words.to_currency(12.5, :gu, minor: :never)).to eq("બાર રૂપિયા")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :gu)).to eq("એકવીસમા ઑગસ્ટ બે હજાર ચોવીસ")
      expect(Num2words.to_words("14:35:42", :gu)).to eq("ચૌદ કલાક પાંત્રીસ મિનિટ બેતાલીસ સેકંડ")
      expect(Num2words.to_words("2024-08-21 14:35:42", :gu)).to eq(
        "એકવીસમા ઑગસ્ટ બે હજાર ચોવીસ, ચૌદ કલાક પાંત્રીસ મિનિટ બેતાલીસ સેકંડ"
      )
    end
  end
end
