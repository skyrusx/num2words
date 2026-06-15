# frozen_string_literal: true

require "num2words"

RSpec.describe "Hungarian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :hu)).to eq("nulla")
      expect(Num2words.to_words(1, :hu)).to eq("egy")
      expect(Num2words.to_words(2, :hu)).to eq("kettő")
      expect(Num2words.to_words(5, :hu)).to eq("öt")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :hu)).to eq("tíz")
      expect(Num2words.to_words(11, :hu)).to eq("tizenegy")
      expect(Num2words.to_words(19, :hu)).to eq("tizenkilenc")
      expect(Num2words.to_words(20, :hu)).to eq("húsz")
      expect(Num2words.to_words(21, :hu)).to eq("huszonegy")
      expect(Num2words.to_words(24, :hu)).to eq("huszonnégy")
      expect(Num2words.to_words(35, :hu)).to eq("harmincöt")
      expect(Num2words.to_words(99, :hu)).to eq("kilencvenkilenc")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :hu)).to eq("száz")
      expect(Num2words.to_words(101, :hu)).to eq("százegy")
      expect(Num2words.to_words(105, :hu)).to eq("százöt")
      expect(Num2words.to_words(124, :hu)).to eq("százhuszonnégy")
      expect(Num2words.to_words(999, :hu)).to eq("kilencszázkilencvenkilenc")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :hu)).to eq("egy ezer")
      expect(Num2words.to_words(2_000, :hu)).to eq("kettő ezer")
      expect(Num2words.to_words(5_000, :hu)).to eq("öt ezer")
      expect(Num2words.to_words(21_000, :hu)).to eq("huszonegy ezer")
      expect(Num2words.to_words(22_000, :hu)).to eq("huszonkettő ezer")
      expect(Num2words.to_words(25_000, :hu)).to eq("huszonöt ezer")
      expect(Num2words.to_words(1_001, :hu)).to eq("egy ezer egy")
      expect(Num2words.to_words(2_002, :hu)).to eq("kettő ezer kettő")
      expect(Num2words.to_words(5_005, :hu)).to eq("öt ezer öt")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :hu)).to eq("egy millió")
      expect(Num2words.to_words(2_000_000, :hu)).to eq("kettő millió")
      expect(Num2words.to_words(5_000_000, :hu)).to eq("öt millió")
      expect(Num2words.to_words(1_000_000_000, :hu)).to eq("egy milliárd")
      expect(Num2words.to_words(2_000_000_000, :hu)).to eq("kettő milliárd")
      expect(Num2words.to_words(5_000_000_000, :hu)).to eq("öt milliárd")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :hu)).to eq("egy millió kétszázharmincnégy ezer ötszázhatvanhét")
      expect(Num2words.to_words(1_000_001, :hu)).to eq("egy millió egy")
      expect(Num2words.to_words(2_021_004, :hu)).to eq("kettő millió huszonegy ezer négy")
    end
  end

  context "feminine option" do
    it "does not change Hungarian output" do
      expect(Num2words.to_words(1, :hu, feminine: true)).to eq("egy")
      expect(Num2words.to_words(2, :hu, feminine: true)).to eq("kettő")
      expect(Num2words.to_words(21, :hu, feminine: true)).to eq("huszonegy")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :hu)).to eq("mínusz egy")
      expect(Num2words.to_words(-21, :hu)).to eq("mínusz huszonegy")
      expect(Num2words.to_words(-1_000, :hu)).to eq("mínusz egy ezer")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :hu)).to eq("hét")
      expect(Num2words.to_words("-42", :hu)).to eq("mínusz negyvenkettő")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :hu)).to eq("három egész öt tized")
      expect(Num2words.to_words("3,5", :hu)).to eq("három egész öt tized")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :hu)).to eq("nulla egész öt tized")
      expect(Num2words.to_words(2.25, :hu)).to eq("kettő egész huszonöt század")
      expect(Num2words.to_words(3.01, :hu)).to eq("három egész egy század")
      expect(Num2words.to_words(-1.2, :hu)).to eq("mínusz egy egész kettő tized")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :hu, joiner: :and)).to eq("nulla és öt tized")
      expect(Num2words.to_words(12.12, :hu, style: :decimal)).to eq("tizenkettő vessző egy kettő")
      expect(Num2words.to_words("3,05", :hu, style: :decimal)).to eq("három vessző nulla öt")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :hu)).to eq(
        "kilenc milliárd nyolcszázhetvenhat millió ötszáznegyvenhárom ezer kétszáztíz"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :hu)).to eq("tizenegy ezer tizenegy")
      expect(Num2words.to_words(1_011_011, :hu)).to eq("egy millió tizenegy ezer tizenegy")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "huszonegy"
      expect(Num2words.to_words(21, :hu, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :hu, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :hu, word_case: :capitalize)).to eq("Huszonegy")
      expect(Num2words.to_words(21, :hu, word_case: :title)).to eq("Huszonegy")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :hu)).to eq("egy forint nulla fillér")
      expect(Num2words.to_currency(2, :hu)).to eq("kettő forint nulla fillér")
      expect(Num2words.to_currency("12.50", :hu)).to eq("tizenkettő forint ötven fillér")
      expect(Num2words.to_currency("12.50", :hu, code: :BRL)).to eq("tizenkettő brazil real ötven centavo")
      expect(Num2words.to_currency(12, :hu, minor: :nonzero)).to eq("tizenkettő forint")
      expect(Num2words.to_currency(12.5, :hu, minor: :never)).to eq("tizenkettő forint")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :hu)).to eq("kettő ezer huszonnégy. augusztus huszonegyedik")
      expect(Num2words.to_words("14:35:42", :hu)).to eq("tizennégy óra harmincöt perc negyvenkettő másodperc")
      expect(Num2words.to_words("2024-08-21 14:35:42", :hu)).to eq(
        "kettő ezer huszonnégy. augusztus huszonegyedik, tizennégy óra harmincöt perc negyvenkettő másodperc"
      )
    end
  end
end
