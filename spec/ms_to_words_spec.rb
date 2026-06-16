# frozen_string_literal: true

require "num2words"

RSpec.describe "Malay locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ms)).to eq("kosong")
      expect(Num2words.to_words(1, :ms)).to eq("satu")
      expect(Num2words.to_words(2, :ms)).to eq("dua")
      expect(Num2words.to_words(5, :ms)).to eq("lima")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :ms)).to eq("sepuluh")
      expect(Num2words.to_words(11, :ms)).to eq("sebelas")
      expect(Num2words.to_words(19, :ms)).to eq("sembilan belas")
      expect(Num2words.to_words(20, :ms)).to eq("dua puluh")
      expect(Num2words.to_words(21, :ms)).to eq("dua puluh satu")
      expect(Num2words.to_words(24, :ms)).to eq("dua puluh empat")
      expect(Num2words.to_words(35, :ms)).to eq("tiga puluh lima")
      expect(Num2words.to_words(99, :ms)).to eq("sembilan puluh sembilan")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :ms)).to eq("seratus")
      expect(Num2words.to_words(101, :ms)).to eq("seratus satu")
      expect(Num2words.to_words(105, :ms)).to eq("seratus lima")
      expect(Num2words.to_words(124, :ms)).to eq("seratus dua puluh empat")
      expect(Num2words.to_words(999, :ms)).to eq("sembilan ratus sembilan puluh sembilan")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :ms)).to eq("ribu")
      expect(Num2words.to_words(2_000, :ms)).to eq("dua ribu")
      expect(Num2words.to_words(5_000, :ms)).to eq("lima ribu")
      expect(Num2words.to_words(21_000, :ms)).to eq("dua puluh satu ribu")
      expect(Num2words.to_words(22_000, :ms)).to eq("dua puluh dua ribu")
      expect(Num2words.to_words(25_000, :ms)).to eq("dua puluh lima ribu")
      expect(Num2words.to_words(1_001, :ms)).to eq("ribu satu")
      expect(Num2words.to_words(2_002, :ms)).to eq("dua ribu dua")
      expect(Num2words.to_words(5_005, :ms)).to eq("lima ribu lima")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :ms)).to eq("satu juta")
      expect(Num2words.to_words(2_000_000, :ms)).to eq("dua juta")
      expect(Num2words.to_words(5_000_000, :ms)).to eq("lima juta")
      expect(Num2words.to_words(1_000_000_000, :ms)).to eq("satu bilion")
      expect(Num2words.to_words(2_000_000_000, :ms)).to eq("dua bilion")
      expect(Num2words.to_words(5_000_000_000, :ms)).to eq("lima bilion")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :ms)).to eq("satu juta dua ratus tiga puluh empat ribu lima ratus enam puluh tujuh")
      expect(Num2words.to_words(1_000_001, :ms)).to eq("satu juta satu")
      expect(Num2words.to_words(2_021_004, :ms)).to eq("dua juta dua puluh satu ribu empat")
    end
  end

  context "feminine option" do
    it "does not change Malay output" do
      expect(Num2words.to_words(1, :ms, feminine: true)).to eq("satu")
      expect(Num2words.to_words(2, :ms, feminine: true)).to eq("dua")
      expect(Num2words.to_words(21, :ms, feminine: true)).to eq("dua puluh satu")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ms)).to eq("minus satu")
      expect(Num2words.to_words(-21, :ms)).to eq("minus dua puluh satu")
      expect(Num2words.to_words(-1_000, :ms)).to eq("minus ribu")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :ms)).to eq("tujuh")
      expect(Num2words.to_words("-42", :ms)).to eq("minus empat puluh dua")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :ms)).to eq("tiga perpuluhan lima persepuluh")
      expect(Num2words.to_words("3,5", :ms)).to eq("tiga perpuluhan lima persepuluh")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ms)).to eq("kosong perpuluhan lima persepuluh")
      expect(Num2words.to_words(2.25, :ms)).to eq("dua perpuluhan dua puluh lima perseratus")
      expect(Num2words.to_words(3.01, :ms)).to eq("tiga perpuluhan satu perseratus")
      expect(Num2words.to_words(-1.2, :ms)).to eq("minus satu perpuluhan dua persepuluh")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :ms, joiner: :and)).to eq("kosong dan lima persepuluh")
      expect(Num2words.to_words(12.12, :ms, style: :decimal)).to eq("dua belas perpuluhan satu dua")
      expect(Num2words.to_words("3,05", :ms, style: :decimal)).to eq("tiga perpuluhan kosong lima")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :ms)).to eq(
        "sembilan bilion lapan ratus tujuh puluh enam juta lima ratus empat puluh tiga ribu dua ratus sepuluh"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :ms)).to eq("sebelas ribu sebelas")
      expect(Num2words.to_words(1_011_011, :ms)).to eq("satu juta sebelas ribu sebelas")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "dua puluh satu"
      expect(Num2words.to_words(21, :ms, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :ms, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :ms, word_case: :capitalize)).to eq("Dua puluh satu")
      expect(Num2words.to_words(21, :ms, word_case: :title)).to eq("Dua Puluh Satu")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ms)).to eq("satu ringgit kosong sen")
      expect(Num2words.to_currency(2, :ms)).to eq("dua ringgit kosong sen")
      expect(Num2words.to_currency("12.50", :ms)).to eq("dua belas ringgit lima puluh sen")
      expect(Num2words.to_currency("12.50", :ms, code: :BRL)).to eq("dua belas real brazil lima puluh centavo")
      expect(Num2words.to_currency(12, :ms, minor: :nonzero)).to eq("dua belas ringgit")
      expect(Num2words.to_currency(12.5, :ms, minor: :never)).to eq("dua belas ringgit")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ms)).to eq("dua puluh satu Ogos dua ribu dua puluh empat")
      expect(Num2words.to_words("14:35:42", :ms)).to eq("empat belas jam tiga puluh lima minit empat puluh dua saat")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ms)).to eq(
        "dua puluh satu Ogos dua ribu dua puluh empat, empat belas jam tiga puluh lima minit empat puluh dua saat"
      )
    end
  end
end
