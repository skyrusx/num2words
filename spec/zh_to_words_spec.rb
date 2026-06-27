# frozen_string_literal: true

require "num2words"

RSpec.describe "Chinese locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :zh)).to eq("零")
      expect(Num2words.to_words(1, :zh)).to eq("一")
      expect(Num2words.to_words(2, :zh)).to eq("二")
      expect(Num2words.to_words(5, :zh)).to eq("五")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :zh)).to eq("十")
      expect(Num2words.to_words(11, :zh)).to eq("十一")
      expect(Num2words.to_words(19, :zh)).to eq("十九")
      expect(Num2words.to_words(20, :zh)).to eq("二十")
      expect(Num2words.to_words(21, :zh)).to eq("二十一")
      expect(Num2words.to_words(24, :zh)).to eq("二十四")
      expect(Num2words.to_words(35, :zh)).to eq("三十五")
      expect(Num2words.to_words(99, :zh)).to eq("九十九")
    end

    it "converts hundreds and internal zeros" do
      expect(Num2words.to_words(100, :zh)).to eq("一百")
      expect(Num2words.to_words(101, :zh)).to eq("一百零一")
      expect(Num2words.to_words(105, :zh)).to eq("一百零五")
      expect(Num2words.to_words(124, :zh)).to eq("一百二十四")
      expect(Num2words.to_words(999, :zh)).to eq("九百九十九")
      expect(Num2words.to_words(1_001, :zh)).to eq("一千零一")
      expect(Num2words.to_words(1_010, :zh)).to eq("一千零一十")
    end
  end

  context "four-digit scale groups" do
    it "converts thousands, wan and yi" do
      expect(Num2words.to_words(1_000, :zh)).to eq("一千")
      expect(Num2words.to_words(10_000, :zh)).to eq("一万")
      expect(Num2words.to_words(100_000_000, :zh)).to eq("一亿")
      expect(Num2words.to_words(1_000_000_000_000, :zh)).to eq("一兆")
    end

    it "inserts zero between incomplete lower groups" do
      expect(Num2words.to_words(10_001, :zh)).to eq("一万零一")
      expect(Num2words.to_words(1_000_001, :zh)).to eq("一百万零一")
      expect(Num2words.to_words(1_011_011, :zh)).to eq("一百零一万一千零一十一")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :zh)).to eq("一百二十三万四千五百六十七")
      expect(Num2words.to_words(123_456_789, :zh)).to eq("一亿二千三百四十五万六千七百八十九")
    end
  end

  context "feminine option" do
    it "does not change Chinese output" do
      expect(Num2words.to_words(1, :zh, feminine: true)).to eq("一")
      expect(Num2words.to_words(2, :zh, feminine: true)).to eq("二")
      expect(Num2words.to_words(21, :zh, feminine: true)).to eq("二十一")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :zh)).to eq("负一")
      expect(Num2words.to_words(-21, :zh)).to eq("负二十一")
      expect(Num2words.to_words(-1_000, :zh)).to eq("负一千")
    end
  end

  context "string input" do
    it "recognizes integer and decimal strings" do
      expect(Num2words.to_words("007", :zh)).to eq("七")
      expect(Num2words.to_words("-42", :zh)).to eq("负四十二")
      expect(Num2words.to_words("3.5", :zh)).to eq("三点十分之五")
      expect(Num2words.to_words("3,5", :zh)).to eq("三点十分之五")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :zh)).to eq("零点十分之五")
      expect(Num2words.to_words(2.25, :zh)).to eq("二点百分之二十五")
      expect(Num2words.to_words(3.01, :zh)).to eq("三点百分之一")
      expect(Num2words.to_words(-1.2, :zh)).to eq("负一点十分之二")
    end

    it "uses decimal digit style" do
      expect(Num2words.to_words(12.12, :zh, style: :decimal)).to eq("十二点一二")
      expect(Num2words.to_words("3,05", :zh, style: :decimal)).to eq("三点零五")
      expect(Num2words.to_words(0.5, :zh, joiner: :and)).to eq("零又十分之五")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :zh)).to eq("九十八亿七千六百五十四万三千二百一十")
    end
  end

  context "word case" do
    it "applies case options without changing Chinese text" do
      base = "二十一"
      expect(Num2words.to_words(21, :zh, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :zh, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :zh, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :zh, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :zh)).to eq("一元零分")
      expect(Num2words.to_currency(2, :zh)).to eq("二元零分")
      expect(Num2words.to_currency("12.50", :zh)).to eq("十二元五十分")
      expect(Num2words.to_currency("12.50", :zh, code: :BRL)).to eq("十二巴西雷亚尔五十分")
      expect(Num2words.to_currency(12, :zh, minor: :nonzero)).to eq("十二元")
      expect(Num2words.to_currency(12.5, :zh, minor: :never)).to eq("十二元")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :zh)).to eq("二千零二十四年八月二十一日")
      expect(Num2words.to_words("14:35:42", :zh)).to eq("十四点三十五分四十二秒")
      expect(Num2words.to_words("2024-08-21 14:35:42", :zh)).to eq(
        "二千零二十四年八月二十一日 十四点三十五分四十二秒"
      )
    end
  end
end
