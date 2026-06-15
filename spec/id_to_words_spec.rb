# frozen_string_literal: true

require "num2words"

RSpec.describe "Indonesian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :id)).to eq("nol")
      expect(Num2words.to_words(1, :id)).to eq("satu")
      expect(Num2words.to_words(2, :id)).to eq("dua")
      expect(Num2words.to_words(5, :id)).to eq("lima")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :id)).to eq("sepuluh")
      expect(Num2words.to_words(11, :id)).to eq("sebelas")
      expect(Num2words.to_words(19, :id)).to eq("sembilan belas")
      expect(Num2words.to_words(20, :id)).to eq("dua puluh")
      expect(Num2words.to_words(21, :id)).to eq("dua puluh satu")
      expect(Num2words.to_words(24, :id)).to eq("dua puluh empat")
      expect(Num2words.to_words(35, :id)).to eq("tiga puluh lima")
      expect(Num2words.to_words(99, :id)).to eq("sembilan puluh sembilan")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :id)).to eq("seratus")
      expect(Num2words.to_words(101, :id)).to eq("seratus satu")
      expect(Num2words.to_words(105, :id)).to eq("seratus lima")
      expect(Num2words.to_words(124, :id)).to eq("seratus dua puluh empat")
      expect(Num2words.to_words(999, :id)).to eq("sembilan ratus sembilan puluh sembilan")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :id)).to eq("ribu")
      expect(Num2words.to_words(2_000, :id)).to eq("dua ribu")
      expect(Num2words.to_words(5_000, :id)).to eq("lima ribu")
      expect(Num2words.to_words(21_000, :id)).to eq("dua puluh satu ribu")
      expect(Num2words.to_words(22_000, :id)).to eq("dua puluh dua ribu")
      expect(Num2words.to_words(25_000, :id)).to eq("dua puluh lima ribu")
      expect(Num2words.to_words(1_001, :id)).to eq("ribu satu")
      expect(Num2words.to_words(2_002, :id)).to eq("dua ribu dua")
      expect(Num2words.to_words(5_005, :id)).to eq("lima ribu lima")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :id)).to eq("satu juta")
      expect(Num2words.to_words(2_000_000, :id)).to eq("dua juta")
      expect(Num2words.to_words(5_000_000, :id)).to eq("lima juta")
      expect(Num2words.to_words(1_000_000_000, :id)).to eq("satu miliar")
      expect(Num2words.to_words(2_000_000_000, :id)).to eq("dua miliar")
      expect(Num2words.to_words(5_000_000_000, :id)).to eq("lima miliar")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :id)).to eq("satu juta dua ratus tiga puluh empat ribu lima ratus enam puluh tujuh")
      expect(Num2words.to_words(1_000_001, :id)).to eq("satu juta satu")
      expect(Num2words.to_words(2_021_004, :id)).to eq("dua juta dua puluh satu ribu empat")
    end
  end

  context "feminine option" do
    it "does not change Indonesian output" do
      expect(Num2words.to_words(1, :id, feminine: true)).to eq("satu")
      expect(Num2words.to_words(2, :id, feminine: true)).to eq("dua")
      expect(Num2words.to_words(21, :id, feminine: true)).to eq("dua puluh satu")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :id)).to eq("minus satu")
      expect(Num2words.to_words(-21, :id)).to eq("minus dua puluh satu")
      expect(Num2words.to_words(-1_000, :id)).to eq("minus ribu")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :id)).to eq("tujuh")
      expect(Num2words.to_words("-42", :id)).to eq("minus empat puluh dua")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :id)).to eq("tiga koma lima persepuluh")
      expect(Num2words.to_words("3,5", :id)).to eq("tiga koma lima persepuluh")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :id)).to eq("nol koma lima persepuluh")
      expect(Num2words.to_words(2.25, :id)).to eq("dua koma dua puluh lima perseratus")
      expect(Num2words.to_words(3.01, :id)).to eq("tiga koma satu perseratus")
      expect(Num2words.to_words(-1.2, :id)).to eq("minus satu koma dua persepuluh")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :id, joiner: :and)).to eq("nol dan lima persepuluh")
      expect(Num2words.to_words(12.12, :id, style: :decimal)).to eq("dua belas koma satu dua")
      expect(Num2words.to_words("3,05", :id, style: :decimal)).to eq("tiga koma nol lima")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :id)).to eq(
        "sembilan miliar delapan ratus tujuh puluh enam juta lima ratus empat puluh tiga ribu dua ratus sepuluh"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :id)).to eq("sebelas ribu sebelas")
      expect(Num2words.to_words(1_011_011, :id)).to eq("satu juta sebelas ribu sebelas")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "dua puluh satu"
      expect(Num2words.to_words(21, :id, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :id, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :id, word_case: :capitalize)).to eq("Dua puluh satu")
      expect(Num2words.to_words(21, :id, word_case: :title)).to eq("Dua Puluh Satu")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :id)).to eq("satu rupiah nol sen")
      expect(Num2words.to_currency(2, :id)).to eq("dua rupiah nol sen")
      expect(Num2words.to_currency("12.50", :id)).to eq("dua belas rupiah lima puluh sen")
      expect(Num2words.to_currency("12.50", :id, code: :BRL)).to eq("dua belas real brasil lima puluh centavo")
      expect(Num2words.to_currency(12, :id, minor: :nonzero)).to eq("dua belas rupiah")
      expect(Num2words.to_currency(12.5, :id, minor: :never)).to eq("dua belas rupiah")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :id)).to eq("dua puluh satu Agustus dua ribu dua puluh empat")
      expect(Num2words.to_words("14:35:42", :id)).to eq("empat belas jam tiga puluh lima menit empat puluh dua detik")
      expect(Num2words.to_words("2024-08-21 14:35:42", :id)).to eq(
        "dua puluh satu Agustus dua ribu dua puluh empat, empat belas jam tiga puluh lima menit empat puluh dua detik"
      )
    end
  end
end
