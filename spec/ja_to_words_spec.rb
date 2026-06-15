# frozen_string_literal: true

require "num2words"

RSpec.describe "Japanese locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ja)).to eq("ゼロ")
      expect(Num2words.to_words(1, :ja)).to eq("いち")
      expect(Num2words.to_words(2, :ja)).to eq("に")
      expect(Num2words.to_words(5, :ja)).to eq("ご")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :ja)).to eq("じゅう")
      expect(Num2words.to_words(11, :ja)).to eq("じゅういち")
      expect(Num2words.to_words(19, :ja)).to eq("じゅうきゅう")
      expect(Num2words.to_words(20, :ja)).to eq("にじゅう")
      expect(Num2words.to_words(21, :ja)).to eq("にじゅういち")
      expect(Num2words.to_words(24, :ja)).to eq("にじゅうよん")
      expect(Num2words.to_words(35, :ja)).to eq("さんじゅうご")
      expect(Num2words.to_words(99, :ja)).to eq("きゅうじゅうきゅう")
    end

    it "converts hundreds and thousands" do
      expect(Num2words.to_words(100, :ja)).to eq("ひゃく")
      expect(Num2words.to_words(101, :ja)).to eq("ひゃくいち")
      expect(Num2words.to_words(105, :ja)).to eq("ひゃくご")
      expect(Num2words.to_words(124, :ja)).to eq("ひゃくにじゅうよん")
      expect(Num2words.to_words(999, :ja)).to eq("きゅうひゃくきゅうじゅうきゅう")
      expect(Num2words.to_words(3_000, :ja)).to eq("さんぜん")
      expect(Num2words.to_words(8_000, :ja)).to eq("はっせん")
    end
  end

  context "large numbers" do
    it "uses Japanese four-digit scale groups" do
      expect(Num2words.to_words(1_000, :ja)).to eq("せん")
      expect(Num2words.to_words(10_000, :ja)).to eq("いちまん")
      expect(Num2words.to_words(100_000_000, :ja)).to eq("いちおく")
      expect(Num2words.to_words(1_234_567, :ja)).to eq("ひゃくにじゅうさんまんよんせんごひゃくろくじゅうなな")
      expect(Num2words.to_words(123_456_789, :ja)).to eq("いちおくにせんさんびゃくよんじゅうごまんろくせんななひゃくはちじゅうきゅう")
    end
  end

  context "feminine option" do
    it "does not change Japanese output" do
      expect(Num2words.to_words(1, :ja, feminine: true)).to eq("いち")
      expect(Num2words.to_words(2, :ja, feminine: true)).to eq("に")
      expect(Num2words.to_words(21, :ja, feminine: true)).to eq("にじゅういち")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ja)).to eq("マイナスいち")
      expect(Num2words.to_words(-21, :ja)).to eq("マイナスにじゅういち")
      expect(Num2words.to_words(-1_000, :ja)).to eq("マイナスせん")
    end
  end

  context "string input" do
    it "recognizes integer and decimal strings" do
      expect(Num2words.to_words("007", :ja)).to eq("なな")
      expect(Num2words.to_words("-42", :ja)).to eq("マイナスよんじゅうに")
      expect(Num2words.to_words("3.5", :ja)).to eq("さんとじゅうぶんのご")
      expect(Num2words.to_words("3,5", :ja)).to eq("さんとじゅうぶんのご")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ja)).to eq("ゼロとじゅうぶんのご")
      expect(Num2words.to_words(2.25, :ja)).to eq("にとひゃくぶんのにじゅうご")
      expect(Num2words.to_words(3.01, :ja)).to eq("さんとひゃくぶんのいち")
      expect(Num2words.to_words(-1.2, :ja)).to eq("マイナスいちとじゅうぶんのに")
    end

    it "uses decimal digit style" do
      expect(Num2words.to_words(12.12, :ja, style: :decimal)).to eq("じゅうにてんいちに")
      expect(Num2words.to_words("3,05", :ja, style: :decimal)).to eq("さんてんゼロご")
      expect(Num2words.to_words(0.5, :ja, joiner: :and)).to eq("ゼロとじゅうぶんのご")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ja)).to eq("いち円ゼロ銭")
      expect(Num2words.to_currency(2, :ja)).to eq("に円ゼロ銭")
      expect(Num2words.to_currency("12.50", :ja)).to eq("じゅうに円ごじゅう銭")
      expect(Num2words.to_currency("12.50", :ja, code: :BRL)).to eq("じゅうにブラジルレアルごじゅうセンターボ")
      expect(Num2words.to_currency(12, :ja, minor: :nonzero)).to eq("じゅうに円")
      expect(Num2words.to_currency(12.5, :ja, minor: :never)).to eq("じゅうに円")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ja)).to eq("にせんにじゅうよん年8月にじゅういち日")
      expect(Num2words.to_words("14:35:42", :ja)).to eq("じゅうよん時さんじゅうご分よんじゅうに秒")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ja)).to eq(
        "にせんにじゅうよん年8月にじゅういち日 じゅうよん時さんじゅうご分よんじゅうに秒"
      )
    end
  end
end
