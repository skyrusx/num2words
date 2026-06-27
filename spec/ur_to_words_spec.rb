# frozen_string_literal: true

require "num2words"

RSpec.describe "Urdu locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ur)).to eq("صفر")
      expect(Num2words.to_words(1, :ur)).to eq("ایک")
      expect(Num2words.to_words(2, :ur)).to eq("دو")
      expect(Num2words.to_words(5, :ur)).to eq("پانچ")
    end

    it "converts Urdu-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :ur)).to eq("دس")
      expect(Num2words.to_words(11, :ur)).to eq("گیارہ")
      expect(Num2words.to_words(19, :ur)).to eq("انیس")
      expect(Num2words.to_words(20, :ur)).to eq("بیس")
      expect(Num2words.to_words(21, :ur)).to eq("اکیس")
      expect(Num2words.to_words(24, :ur)).to eq("چوبیس")
      expect(Num2words.to_words(35, :ur)).to eq("پینتیس")
      expect(Num2words.to_words(99, :ur)).to eq("ننانوے")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :ur)).to eq("سو")
      expect(Num2words.to_words(101, :ur)).to eq("سو ایک")
      expect(Num2words.to_words(105, :ur)).to eq("سو پانچ")
      expect(Num2words.to_words(124, :ur)).to eq("سو چوبیس")
      expect(Num2words.to_words(999, :ur)).to eq("نو سو ننانوے")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :ur)).to eq("ایک ہزار")
      expect(Num2words.to_words(2_000, :ur)).to eq("دو ہزار")
      expect(Num2words.to_words(5_000, :ur)).to eq("پانچ ہزار")
      expect(Num2words.to_words(21_000, :ur)).to eq("اکیس ہزار")
      expect(Num2words.to_words(22_000, :ur)).to eq("بائیس ہزار")
      expect(Num2words.to_words(25_000, :ur)).to eq("پچیس ہزار")
      expect(Num2words.to_words(1_001, :ur)).to eq("ایک ہزار ایک")
      expect(Num2words.to_words(2_002, :ur)).to eq("دو ہزار دو")
      expect(Num2words.to_words(5_005, :ur)).to eq("پانچ ہزار پانچ")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :ur)).to eq("ایک لاکھ")
      expect(Num2words.to_words(2_000_000, :ur)).to eq("بیس لاکھ")
      expect(Num2words.to_words(10_000_000, :ur)).to eq("ایک کروڑ")
      expect(Num2words.to_words(1_000_000_000, :ur)).to eq("ایک ارب")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :ur)).to eq("بارہ لاکھ چونتیس ہزار پانچ سو سڑسٹھ")
      expect(Num2words.to_words(1_000_001, :ur)).to eq("دس لاکھ ایک")
      expect(Num2words.to_words(2_021_004, :ur)).to eq("بیس لاکھ اکیس ہزار چار")
    end
  end

  context "feminine option" do
    it "does not change Urdu output" do
      expect(Num2words.to_words(1, :ur, feminine: true)).to eq("ایک")
      expect(Num2words.to_words(2, :ur, feminine: true)).to eq("دو")
      expect(Num2words.to_words(21, :ur, feminine: true)).to eq("اکیس")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ur)).to eq("منفی ایک")
      expect(Num2words.to_words(-21, :ur)).to eq("منفی اکیس")
      expect(Num2words.to_words(-1_000, :ur)).to eq("منفی ایک ہزار")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :ur)).to eq("سات")
      expect(Num2words.to_words("-42", :ur)).to eq("منفی بیالیس")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :ur)).to eq("تین صحیح پانچ دسویں")
      expect(Num2words.to_words("3,5", :ur)).to eq("تین صحیح پانچ دسویں")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ur)).to eq("صفر صحیح پانچ دسویں")
      expect(Num2words.to_words(2.25, :ur)).to eq("دو صحیح پچیس سوویں")
      expect(Num2words.to_words(3.01, :ur)).to eq("تین صحیح ایک سواں")
      expect(Num2words.to_words(-1.2, :ur)).to eq("منفی ایک صحیح دو دسویں")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :ur, joiner: :and)).to eq("صفر اور پانچ دسویں")
      expect(Num2words.to_words(12.12, :ur, style: :decimal)).to eq("بارہ اعشاریہ ایک دو")
      expect(Num2words.to_words("3,05", :ur, style: :decimal)).to eq("تین اعشاریہ صفر پانچ")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :ur)).to eq(
        "نو ارب ستاسی کروڑ پینسٹھ لاکھ تینتالیس ہزار دو سو دس"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :ur)).to eq("گیارہ ہزار گیارہ")
      expect(Num2words.to_words(1_011_011, :ur)).to eq("دس لاکھ گیارہ ہزار گیارہ")
    end
  end

  context "word case" do
    it "applies case options without changing Urdu text" do
      base = "اکیس"
      expect(Num2words.to_words(21, :ur, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :ur, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :ur, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :ur, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ur)).to eq("ایک روپیہ صفر پیسے")
      expect(Num2words.to_currency(2, :ur)).to eq("دو روپے صفر پیسے")
      expect(Num2words.to_currency("12.50", :ur)).to eq("بارہ روپے پچاس پیسے")
      expect(Num2words.to_currency("12.50", :ur, code: :BRL)).to eq("بارہ برازیلی ریئل پچاس سینٹاوو")
      expect(Num2words.to_currency(12, :ur, minor: :nonzero)).to eq("بارہ روپے")
      expect(Num2words.to_currency(12.5, :ur, minor: :never)).to eq("بارہ روپے")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ur)).to eq("اکیسویں اگست دو ہزار چوبیس")
      expect(Num2words.to_words("14:35:42", :ur)).to eq("چودہ گھنٹے پینتیس منٹ بیالیس سیکنڈ")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ur)).to eq(
        "اکیسویں اگست دو ہزار چوبیس, چودہ گھنٹے پینتیس منٹ بیالیس سیکنڈ"
      )
    end
  end
end
