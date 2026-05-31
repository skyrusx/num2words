# frozen_string_literal: true

require "num2words"

RSpec.describe "Bengali locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :bn)).to eq("শূন্য")
      expect(Num2words.to_words(1, :bn)).to eq("এক")
      expect(Num2words.to_words(2, :bn)).to eq("দুই")
      expect(Num2words.to_words(5, :bn)).to eq("পাঁচ")
    end

    it "converts Bengali-specific numbers below one hundred" do
      expect(Num2words.to_words(10, :bn)).to eq("দশ")
      expect(Num2words.to_words(11, :bn)).to eq("এগারো")
      expect(Num2words.to_words(19, :bn)).to eq("উনিশ")
      expect(Num2words.to_words(20, :bn)).to eq("বিশ")
      expect(Num2words.to_words(21, :bn)).to eq("একুশ")
      expect(Num2words.to_words(24, :bn)).to eq("চব্বিশ")
      expect(Num2words.to_words(35, :bn)).to eq("পঁয়ত্রিশ")
      expect(Num2words.to_words(99, :bn)).to eq("নিরানব্বই")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :bn)).to eq("একশ")
      expect(Num2words.to_words(101, :bn)).to eq("একশ এক")
      expect(Num2words.to_words(105, :bn)).to eq("একশ পাঁচ")
      expect(Num2words.to_words(124, :bn)).to eq("একশ চব্বিশ")
      expect(Num2words.to_words(999, :bn)).to eq("নয়শ নিরানব্বই")
    end
  end

  context "thousands and Indian scales" do
    it "converts thousands" do
      expect(Num2words.to_words(1_000, :bn)).to eq("এক হাজার")
      expect(Num2words.to_words(2_000, :bn)).to eq("দুই হাজার")
      expect(Num2words.to_words(5_000, :bn)).to eq("পাঁচ হাজার")
      expect(Num2words.to_words(21_000, :bn)).to eq("একুশ হাজার")
      expect(Num2words.to_words(22_000, :bn)).to eq("বাইশ হাজার")
      expect(Num2words.to_words(25_000, :bn)).to eq("পঁচিশ হাজার")
      expect(Num2words.to_words(1_001, :bn)).to eq("এক হাজার এক")
      expect(Num2words.to_words(2_002, :bn)).to eq("দুই হাজার দুই")
      expect(Num2words.to_words(5_005, :bn)).to eq("পাঁচ হাজার পাঁচ")
    end

    it "converts lakh and crore values" do
      expect(Num2words.to_words(100_000, :bn)).to eq("এক লক্ষ")
      expect(Num2words.to_words(1_000_000, :bn)).to eq("দশ লক্ষ")
      expect(Num2words.to_words(10_000_000, :bn)).to eq("এক কোটি")
      expect(Num2words.to_words(50_000_000, :bn)).to eq("পাঁচ কোটি")
    end
  end

  context "large numbers" do
    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :bn)).to eq("বারো লক্ষ চৌত্রিশ হাজার পাঁচশ সাতষট্টি")
      expect(Num2words.to_words(1_000_001, :bn)).to eq("দশ লক্ষ এক")
      expect(Num2words.to_words(2_021_004, :bn)).to eq("বিশ লক্ষ একুশ হাজার চার")
    end

    it "converts range edges" do
      expect(Num2words.to_words(9_876_543_210, :bn)).to eq(
        "নয় অরব সাতাশি কোটি পঁয়ষট্টি লক্ষ তেতাল্লিশ হাজার দুইশ দশ"
      )
      expect(Num2words.to_words(11_011, :bn)).to eq("এগারো হাজার এগারো")
      expect(Num2words.to_words(1_011_011, :bn)).to eq("দশ লক্ষ এগারো হাজার এগারো")
    end
  end

  context "feminine option" do
    it "does not change Bengali output" do
      expect(Num2words.to_words(1, :bn, feminine: true)).to eq("এক")
      expect(Num2words.to_words(2, :bn, feminine: true)).to eq("দুই")
      expect(Num2words.to_words(21, :bn, feminine: true)).to eq("একুশ")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :bn)).to eq("ঋণাত্মক এক")
      expect(Num2words.to_words(-21, :bn)).to eq("ঋণাত্মক একুশ")
      expect(Num2words.to_words(-1_000, :bn)).to eq("ঋণাত্মক এক হাজার")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :bn)).to eq("সাত")
      expect(Num2words.to_words("-42", :bn)).to eq("ঋণাত্মক বিয়াল্লিশ")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :bn)).to eq("তিন পুরো পাঁচ দশমাংশ")
      expect(Num2words.to_words("3,5", :bn)).to eq("তিন পুরো পাঁচ দশমাংশ")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :bn)).to eq("শূন্য পুরো পাঁচ দশমাংশ")
      expect(Num2words.to_words(2.25, :bn)).to eq("দুই পুরো পঁচিশ শতাংশ")
      expect(Num2words.to_words(3.01, :bn)).to eq("তিন পুরো এক শতাংশ")
      expect(Num2words.to_words(-1.2, :bn)).to eq("ঋণাত্মক এক পুরো দুই দশমাংশ")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :bn, joiner: :and)).to eq("শূন্য এবং পাঁচ দশমাংশ")
      expect(Num2words.to_words(2.25, :bn, joiner: :and)).to eq("দুই এবং পঁচিশ শতাংশ")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :bn, style: :decimal)).to eq("বারো পুরো এক দুই")
      expect(Num2words.to_words("3,05", :bn, style: :decimal)).to eq("তিন পুরো শূন্য পাঁচ")
    end
  end

  context "word case" do
    it "applies case options without changing Bengali letters" do
      base = "একুশ"
      expect(Num2words.to_words(21, :bn, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :bn, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :bn, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :bn, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :bn)).to eq("এক টাকা শূন্য পয়সা")
      expect(Num2words.to_currency(2, :bn)).to eq("দুই টাকা শূন্য পয়সা")
      expect(Num2words.to_currency("12.50", :bn)).to eq("বারো টাকা পঞ্চাশ পয়সা")
      expect(Num2words.to_currency("12.50", :bn, code: :BRL)).to eq("বারো ব্রাজিলীয় রিয়াল পঞ্চাশ সেন্টাভো")
      expect(Num2words.to_currency(12, :bn, minor: :nonzero)).to eq("বারো টাকা")
      expect(Num2words.to_currency(12.5, :bn, minor: :never)).to eq("বারো টাকা")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :bn)).to eq("একবিংশ আগস্ট, দুই হাজার চব্বিশ")
      expect(Num2words.to_words("2024-08-21", :bn, date_case: :genitive)).to eq("একবিংশ আগস্ট, দুই হাজার চব্বিশ")
      expect(Num2words.to_words("14:35:42", :bn)).to eq("চৌদ্দ ঘন্টা পঁয়ত্রিশ মিনিট বিয়াল্লিশ সেকেন্ড")
      expect(Num2words.to_words("2024-08-21 14:35:42", :bn)).to eq(
        "একবিংশ আগস্ট, দুই হাজার চব্বিশ, চৌদ্দ ঘন্টা পঁয়ত্রিশ মিনিট বিয়াল্লিশ সেকেন্ড"
      )
    end
  end
end
