# frozen_string_literal: true

require "num2words"

RSpec.describe "Estonian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :et)).to eq("null")
      expect(Num2words.to_words(1, :et)).to eq("üks")
      expect(Num2words.to_words(2, :et)).to eq("kaks")
      expect(Num2words.to_words(5, :et)).to eq("viis")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :et)).to eq("kümme")
      expect(Num2words.to_words(11, :et)).to eq("üksteist")
      expect(Num2words.to_words(19, :et)).to eq("üheksateist")
      expect(Num2words.to_words(20, :et)).to eq("kakskümmend")
      expect(Num2words.to_words(21, :et)).to eq("kakskümmend üks")
      expect(Num2words.to_words(24, :et)).to eq("kakskümmend neli")
      expect(Num2words.to_words(35, :et)).to eq("kolmkümmend viis")
      expect(Num2words.to_words(99, :et)).to eq("üheksakümmend üheksa")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :et)).to eq("sada")
      expect(Num2words.to_words(101, :et)).to eq("sada üks")
      expect(Num2words.to_words(105, :et)).to eq("sada viis")
      expect(Num2words.to_words(124, :et)).to eq("sada kakskümmend neli")
      expect(Num2words.to_words(999, :et)).to eq("üheksasada üheksakümmend üheksa")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :et)).to eq("tuhat")
      expect(Num2words.to_words(2_000, :et)).to eq("kaks tuhat")
      expect(Num2words.to_words(5_000, :et)).to eq("viis tuhat")
      expect(Num2words.to_words(21_000, :et)).to eq("kakskümmend üks tuhat")
      expect(Num2words.to_words(22_000, :et)).to eq("kakskümmend kaks tuhat")
      expect(Num2words.to_words(25_000, :et)).to eq("kakskümmend viis tuhat")
      expect(Num2words.to_words(1_001, :et)).to eq("tuhat üks")
      expect(Num2words.to_words(2_002, :et)).to eq("kaks tuhat kaks")
      expect(Num2words.to_words(5_005, :et)).to eq("viis tuhat viis")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :et)).to eq("üks miljon")
      expect(Num2words.to_words(2_000_000, :et)).to eq("kaks miljonit")
      expect(Num2words.to_words(5_000_000, :et)).to eq("viis miljonit")
      expect(Num2words.to_words(1_000_000_000, :et)).to eq("üks miljard")
      expect(Num2words.to_words(2_000_000_000, :et)).to eq("kaks miljardit")
      expect(Num2words.to_words(5_000_000_000, :et)).to eq("viis miljardit")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :et)).to eq("üks miljon kakssada kolmkümmend neli tuhat viissada kuuskümmend seitse")
      expect(Num2words.to_words(1_000_001, :et)).to eq("üks miljon üks")
      expect(Num2words.to_words(2_021_004, :et)).to eq("kaks miljonit kakskümmend üks tuhat neli")
    end
  end

  context "feminine option" do
    it "does not change Estonian output" do
      expect(Num2words.to_words(1, :et, feminine: true)).to eq("üks")
      expect(Num2words.to_words(2, :et, feminine: true)).to eq("kaks")
      expect(Num2words.to_words(21, :et, feminine: true)).to eq("kakskümmend üks")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :et)).to eq("miinus üks")
      expect(Num2words.to_words(-21, :et)).to eq("miinus kakskümmend üks")
      expect(Num2words.to_words(-1_000, :et)).to eq("miinus tuhat")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :et)).to eq("seitse")
      expect(Num2words.to_words("-42", :et)).to eq("miinus nelikümmend kaks")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :et)).to eq("kolm ja viis kümnendikku")
      expect(Num2words.to_words("3,5", :et)).to eq("kolm ja viis kümnendikku")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :et)).to eq("null ja viis kümnendikku")
      expect(Num2words.to_words(2.25, :et)).to eq("kaks ja kakskümmend viis sajandikku")
      expect(Num2words.to_words(3.01, :et)).to eq("kolm ja üks sajandik")
      expect(Num2words.to_words(-1.2, :et)).to eq("miinus üks ja kaks kümnendikku")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :et, style: :decimal)).to eq("kaksteist koma üks kaks")
      expect(Num2words.to_words("3,05", :et, style: :decimal)).to eq("kolm koma null viis")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :et)).to eq(
        "üheksa miljardit kaheksasada seitsekümmend kuus miljonit viissada nelikümmend kolm tuhat kakssada kümme"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :et)).to eq("üksteist tuhat üksteist")
      expect(Num2words.to_words(1_011_011, :et)).to eq("üks miljon üksteist tuhat üksteist")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "kakskümmend üks"
      expect(Num2words.to_words(21, :et, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :et, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :et, word_case: :capitalize)).to eq("Kakskümmend üks")
      expect(Num2words.to_words(21, :et, word_case: :title)).to eq("Kakskümmend Üks")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :et)).to eq("üks euro null senti")
      expect(Num2words.to_currency(2, :et)).to eq("kaks eurot null senti")
      expect(Num2words.to_currency("12.50", :et)).to eq("kaksteist eurot viiskümmend senti")
      expect(Num2words.to_currency("12.50", :et, code: :BRL)).to eq("kaksteist brasiilia reaali viiskümmend sentavot")
      expect(Num2words.to_currency(12, :et, minor: :nonzero)).to eq("kaksteist eurot")
      expect(Num2words.to_currency(12.5, :et, minor: :never)).to eq("kaksteist eurot")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :et)).to eq("kahekümne esimese august kaks tuhat kakskümmend neli")
      expect(Num2words.to_words("14:35:42", :et)).to eq("neliteist tundi kolmkümmend viis minutit nelikümmend kaks sekundit")
      expect(Num2words.to_words("2024-08-21 14:35:42", :et)).to eq(
        "kahekümne esimese august kaks tuhat kakskümmend neli, neliteist tundi kolmkümmend viis minutit nelikümmend kaks sekundit"
      )
    end
  end
end
