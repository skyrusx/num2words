# frozen_string_literal: true

require "num2words"

RSpec.describe "Punjabi locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :pa)).to eq("ਜ਼ੀਰੋ")
      expect(Num2words.to_words(1, :pa)).to eq("ਇੱਕ")
      expect(Num2words.to_words(2, :pa)).to eq("ਦੋ")
      expect(Num2words.to_words(5, :pa)).to eq("ਪੰਜ")
    end

    it "converts Punjabi-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :pa)).to eq("ਦਸ")
      expect(Num2words.to_words(11, :pa)).to eq("ਗਿਆਰਾਂ")
      expect(Num2words.to_words(19, :pa)).to eq("ਉੱਨੀ")
      expect(Num2words.to_words(20, :pa)).to eq("ਵੀਹ")
      expect(Num2words.to_words(21, :pa)).to eq("ਇੱਕੀ")
      expect(Num2words.to_words(24, :pa)).to eq("ਚੌਵੀ")
      expect(Num2words.to_words(35, :pa)).to eq("ਪੈਂਤੀ")
      expect(Num2words.to_words(99, :pa)).to eq("ਨੜਿਨਵੇਂ")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :pa)).to eq("ਸੌ")
      expect(Num2words.to_words(101, :pa)).to eq("ਸੌ ਇੱਕ")
      expect(Num2words.to_words(105, :pa)).to eq("ਸੌ ਪੰਜ")
      expect(Num2words.to_words(124, :pa)).to eq("ਸੌ ਚੌਵੀ")
      expect(Num2words.to_words(999, :pa)).to eq("ਨੌਂ ਸੌ ਨੜਿਨਵੇਂ")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :pa)).to eq("ਇੱਕ ਹਜ਼ਾਰ")
      expect(Num2words.to_words(2_000, :pa)).to eq("ਦੋ ਹਜ਼ਾਰ")
      expect(Num2words.to_words(5_000, :pa)).to eq("ਪੰਜ ਹਜ਼ਾਰ")
      expect(Num2words.to_words(21_000, :pa)).to eq("ਇੱਕੀ ਹਜ਼ਾਰ")
      expect(Num2words.to_words(1_001, :pa)).to eq("ਇੱਕ ਹਜ਼ਾਰ ਇੱਕ")
      expect(Num2words.to_words(2_002, :pa)).to eq("ਦੋ ਹਜ਼ਾਰ ਦੋ")
      expect(Num2words.to_words(5_005, :pa)).to eq("ਪੰਜ ਹਜ਼ਾਰ ਪੰਜ")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :pa)).to eq("ਇੱਕ ਲੱਖ")
      expect(Num2words.to_words(2_000_000, :pa)).to eq("ਵੀਹ ਲੱਖ")
      expect(Num2words.to_words(10_000_000, :pa)).to eq("ਇੱਕ ਕਰੋੜ")
      expect(Num2words.to_words(1_000_000_000, :pa)).to eq("ਇੱਕ ਅਰਬ")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :pa)).to eq("ਬਾਰਾਂ ਲੱਖ ਚੌਂਤੀ ਹਜ਼ਾਰ ਪੰਜ ਸੌ ਸਤਾਹਠ")
      expect(Num2words.to_words(9_876_543_210, :pa)).to eq(
        "ਨੌਂ ਅਰਬ ਸਤਾਸੀ ਕਰੋੜ ਪੈਂਹਠ ਲੱਖ ਤਿਰਤਾਲੀ ਹਜ਼ਾਰ ਦੋ ਸੌ ਦਸ"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :pa)).to eq("ਮਾਇਨਸ ਇੱਕ")
      expect(Num2words.to_words(-21, :pa)).to eq("ਮਾਇਨਸ ਇੱਕੀ")
      expect(Num2words.to_words("-42", :pa)).to eq("ਮਾਇਨਸ ਬਿਆਲੀ")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :pa)).to eq("ਤਿੰਨ ਪੂਰਨ ਪੰਜ ਦਸਵੇਂ")
      expect(Num2words.to_words("3,5", :pa)).to eq("ਤਿੰਨ ਪੂਰਨ ਪੰਜ ਦਸਵੇਂ")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :pa)).to eq("ਜ਼ੀਰੋ ਪੂਰਨ ਪੰਜ ਦਸਵੇਂ")
      expect(Num2words.to_words(2.25, :pa)).to eq("ਦੋ ਪੂਰਨ ਪੱਚੀ ਸੌਵੇਂ")
      expect(Num2words.to_words(3.01, :pa)).to eq("ਤਿੰਨ ਪੂਰਨ ਇੱਕ ਸੌਵਾਂ")
      expect(Num2words.to_words(-1.2, :pa)).to eq("ਮਾਇਨਸ ਇੱਕ ਪੂਰਨ ਦੋ ਦਸਵੇਂ")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :pa, joiner: :and)).to eq("ਜ਼ੀਰੋ ਅਤੇ ਪੰਜ ਦਸਵੇਂ")
      expect(Num2words.to_words(12.12, :pa, style: :decimal)).to eq("ਬਾਰਾਂ ਦਸ਼ਮਲਵ ਇੱਕ ਦੋ")
      expect(Num2words.to_words("3,05", :pa, style: :decimal)).to eq("ਤਿੰਨ ਦਸ਼ਮਲਵ ਜ਼ੀਰੋ ਪੰਜ")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :pa)).to eq("ਇੱਕ ਰੁਪਇਆ ਜ਼ੀਰੋ ਪੈਸੇ")
      expect(Num2words.to_currency(2, :pa)).to eq("ਦੋ ਰੁਪਏ ਜ਼ੀਰੋ ਪੈਸੇ")
      expect(Num2words.to_currency("12.50", :pa)).to eq("ਬਾਰਾਂ ਰੁਪਏ ਪੰਜਾਹ ਪੈਸੇ")
      expect(Num2words.to_currency("12.50", :pa, code: :BRL)).to eq("ਬਾਰਾਂ ਬ੍ਰਾਜ਼ੀਲੀਅਨ ਰਿਆਲ ਪੰਜਾਹ ਸੈਂਟਾਵੋ")
      expect(Num2words.to_currency(12, :pa, minor: :nonzero)).to eq("ਬਾਰਾਂ ਰੁਪਏ")
      expect(Num2words.to_currency(12.5, :pa, minor: :never)).to eq("ਬਾਰਾਂ ਰੁਪਏ")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :pa)).to eq("ਇੱਕੀਵੇਂ ਅਗਸਤ ਦੋ ਹਜ਼ਾਰ ਚੌਵੀ")
      expect(Num2words.to_words("14:35:42", :pa)).to eq("ਚੌਦਾਂ ਘੰਟੇ ਪੈਂਤੀ ਮਿੰਟ ਬਿਆਲੀ ਸਕਿੰਟ")
      expect(Num2words.to_words("2024-08-21 14:35:42", :pa)).to eq(
        "ਇੱਕੀਵੇਂ ਅਗਸਤ ਦੋ ਹਜ਼ਾਰ ਚੌਵੀ, ਚੌਦਾਂ ਘੰਟੇ ਪੈਂਤੀ ਮਿੰਟ ਬਿਆਲੀ ਸਕਿੰਟ"
      )
    end
  end
end
