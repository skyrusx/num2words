# frozen_string_literal: true

require "num2words"

RSpec.describe "Korean locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ko)).to eq("영")
      expect(Num2words.to_words(1, :ko)).to eq("일")
      expect(Num2words.to_words(2, :ko)).to eq("이")
      expect(Num2words.to_words(5, :ko)).to eq("오")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :ko)).to eq("십")
      expect(Num2words.to_words(11, :ko)).to eq("십일")
      expect(Num2words.to_words(19, :ko)).to eq("십구")
      expect(Num2words.to_words(20, :ko)).to eq("이십")
      expect(Num2words.to_words(21, :ko)).to eq("이십일")
      expect(Num2words.to_words(24, :ko)).to eq("이십사")
      expect(Num2words.to_words(35, :ko)).to eq("삼십오")
      expect(Num2words.to_words(99, :ko)).to eq("구십구")
    end

    it "converts hundreds and thousands" do
      expect(Num2words.to_words(100, :ko)).to eq("백")
      expect(Num2words.to_words(101, :ko)).to eq("백일")
      expect(Num2words.to_words(105, :ko)).to eq("백오")
      expect(Num2words.to_words(124, :ko)).to eq("백이십사")
      expect(Num2words.to_words(999, :ko)).to eq("구백구십구")
      expect(Num2words.to_words(1_000, :ko)).to eq("천")
      expect(Num2words.to_words(3_000, :ko)).to eq("삼천")
    end
  end

  context "large numbers" do
    it "uses Korean four-digit scale groups" do
      expect(Num2words.to_words(10_000, :ko)).to eq("일만")
      expect(Num2words.to_words(100_000_000, :ko)).to eq("일억")
      expect(Num2words.to_words(1_234_567, :ko)).to eq("백이십삼만 사천오백육십칠")
      expect(Num2words.to_words(123_456_789, :ko)).to eq("일억 이천삼백사십오만 육천칠백팔십구")
    end
  end

  context "feminine option" do
    it "does not change Korean output" do
      expect(Num2words.to_words(1, :ko, feminine: true)).to eq("일")
      expect(Num2words.to_words(2, :ko, feminine: true)).to eq("이")
      expect(Num2words.to_words(21, :ko, feminine: true)).to eq("이십일")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ko)).to eq("마이너스 일")
      expect(Num2words.to_words(-21, :ko)).to eq("마이너스 이십일")
      expect(Num2words.to_words(-1_000, :ko)).to eq("마이너스 천")
    end
  end

  context "string input" do
    it "recognizes integer and decimal strings" do
      expect(Num2words.to_words("007", :ko)).to eq("칠")
      expect(Num2words.to_words("-42", :ko)).to eq("마이너스 사십이")
      expect(Num2words.to_words("3.5", :ko)).to eq("삼 점 십분의 오")
      expect(Num2words.to_words("3,5", :ko)).to eq("삼 점 십분의 오")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ko)).to eq("영 점 십분의 오")
      expect(Num2words.to_words(2.25, :ko)).to eq("이 점 백분의 이십오")
      expect(Num2words.to_words(3.01, :ko)).to eq("삼 점 백분의 일")
      expect(Num2words.to_words(-1.2, :ko)).to eq("마이너스 일 점 십분의 이")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :ko, joiner: :and)).to eq("영 와 십분의 오")
      expect(Num2words.to_words(12.12, :ko, style: :decimal)).to eq("십이 점 일 이")
      expect(Num2words.to_words("3,05", :ko, style: :decimal)).to eq("삼 점 영 오")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :ko)).to eq(
        "구십팔억 칠천육백오십사만 삼천이백십"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :ko)).to eq("일만 천십일")
      expect(Num2words.to_words(1_011_011, :ko)).to eq("백일만 천십일")
    end
  end

  context "word case" do
    it "applies case options without changing Korean text" do
      base = "이십일"
      expect(Num2words.to_words(21, :ko, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :ko, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :ko, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :ko, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ko)).to eq("일 원 영 전")
      expect(Num2words.to_currency(2, :ko)).to eq("이 원 영 전")
      expect(Num2words.to_currency("12.50", :ko)).to eq("십이 원 오십 전")
      expect(Num2words.to_currency("12.50", :ko, code: :BRL)).to eq("십이 브라질 헤알 오십 센타보")
      expect(Num2words.to_currency(12, :ko, minor: :nonzero)).to eq("십이 원")
      expect(Num2words.to_currency(12.5, :ko, minor: :never)).to eq("십이 원")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ko)).to eq("이천이십사년 8월 이십일일")
      expect(Num2words.to_words("14:35:42", :ko)).to eq("십사 시 삼십오 분 사십이 초")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ko)).to eq(
        "이천이십사년 8월 이십일일, 십사 시 삼십오 분 사십이 초"
      )
    end
  end
end
