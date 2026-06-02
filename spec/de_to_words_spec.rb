# frozen_string_literal: true

require "num2words"

RSpec.describe "German locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :de)).to eq("null")
      expect(Num2words.to_words(1, :de)).to eq("eins")
      expect(Num2words.to_words(2, :de)).to eq("zwei")
      expect(Num2words.to_words(5, :de)).to eq("fünf")
    end

    it "converts German-specific tens and teens" do
      expect(Num2words.to_words(10, :de)).to eq("zehn")
      expect(Num2words.to_words(11, :de)).to eq("elf")
      expect(Num2words.to_words(19, :de)).to eq("neunzehn")
      expect(Num2words.to_words(20, :de)).to eq("zwanzig")
      expect(Num2words.to_words(21, :de)).to eq("einundzwanzig")
      expect(Num2words.to_words(24, :de)).to eq("vierundzwanzig")
      expect(Num2words.to_words(35, :de)).to eq("fünfunddreißig")
      expect(Num2words.to_words(99, :de)).to eq("neunundneunzig")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :de)).to eq("einhundert")
      expect(Num2words.to_words(101, :de)).to eq("einhunderteins")
      expect(Num2words.to_words(105, :de)).to eq("einhundertfünf")
      expect(Num2words.to_words(124, :de)).to eq("einhundertvierundzwanzig")
      expect(Num2words.to_words(999, :de)).to eq("neunhundertneunundneunzig")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :de)).to eq("tausend")
      expect(Num2words.to_words(2_000, :de)).to eq("zwei tausend")
      expect(Num2words.to_words(5_000, :de)).to eq("fünf tausend")
      expect(Num2words.to_words(21_000, :de)).to eq("einundzwanzig tausend")
      expect(Num2words.to_words(1_001, :de)).to eq("tausend eins")
      expect(Num2words.to_words(2_002, :de)).to eq("zwei tausend zwei")
      expect(Num2words.to_words(5_005, :de)).to eq("fünf tausend fünf")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :de)).to eq("eine Million")
      expect(Num2words.to_words(2_000_000, :de)).to eq("zwei Millionen")
      expect(Num2words.to_words(1_000_000_000, :de)).to eq("eine Milliarde")
      expect(Num2words.to_words(2_000_000_000, :de)).to eq("zwei Milliarden")
      expect(Num2words.to_words(1_234_567, :de)).to eq(
        "eine Million zweihundertvierunddreißig tausend fünfhundertsiebenundsechzig"
      )
      expect(Num2words.to_words(9_876_543_210, :de)).to eq(
        "neun Milliarden achthundertsechsundsiebzig Millionen fünfhundertdreiundvierzig tausend zweihundertzehn"
      )
    end
  end

  context "feminine option" do
    it "changes one where applicable" do
      expect(Num2words.to_words(1, :de, feminine: true)).to eq("eine")
      expect(Num2words.to_words(2, :de, feminine: true)).to eq("zwei")
      expect(Num2words.to_words(21, :de, feminine: true)).to eq("einundzwanzig")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :de)).to eq("minus eins")
      expect(Num2words.to_words(-21, :de)).to eq("minus einundzwanzig")
      expect(Num2words.to_words("-42", :de)).to eq("minus zweiundvierzig")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :de)).to eq("drei Komma fünf Zehntel")
      expect(Num2words.to_words("3,5", :de)).to eq("drei Komma fünf Zehntel")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :de)).to eq("null Komma fünf Zehntel")
      expect(Num2words.to_words(2.25, :de)).to eq("zwei Komma fünfundzwanzig Hundertstel")
      expect(Num2words.to_words(3.01, :de)).to eq("drei Komma eins Hundertstel")
      expect(Num2words.to_words(-1.2, :de)).to eq("minus eins Komma zwei Zehntel")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :de, joiner: :and)).to eq("null und fünf Zehntel")
      expect(Num2words.to_words(2.25, :de, joiner: :and)).to eq("zwei und fünfundzwanzig Hundertstel")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :de)).to eq("ein euro null cent")
      expect(Num2words.to_currency(2, :de)).to eq("zwei euro null cent")
      expect(Num2words.to_currency("12.50", :de)).to eq("zwölf euro fünfzig cent")
      expect(Num2words.to_currency("12.50", :de, code: :BRL)).to eq("zwölf brasilianische real fünfzig centavo")
      expect(Num2words.to_currency(12, :de, minor: :nonzero)).to eq("zwölf euro")
      expect(Num2words.to_currency(12.5, :de, minor: :never)).to eq("zwölf euro")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :de)).to eq("einundzwanzigsten August zweitausendvierundzwanzig")
      expect(Num2words.to_words("14:35:42", :de)).to eq("vierzehn Stunden fünfunddreißig Minuten zweiundvierzig Sekunden")
      expect(Num2words.to_words("2024-08-21 14:35:42", :de)).to eq(
        "einundzwanzigsten August zweitausendvierundzwanzig, vierzehn Stunden fünfunddreißig Minuten zweiundvierzig Sekunden"
      )
    end
  end
end
