# frozen_string_literal: true

require "num2words"

RSpec.describe "Vietnamese locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :vi)).to eq("không")
      expect(Num2words.to_words(1, :vi)).to eq("một")
      expect(Num2words.to_words(2, :vi)).to eq("hai")
      expect(Num2words.to_words(5, :vi)).to eq("năm")
    end

    it "converts Vietnamese-specific tens and teens" do
      expect(Num2words.to_words(10, :vi)).to eq("mười")
      expect(Num2words.to_words(11, :vi)).to eq("mười một")
      expect(Num2words.to_words(15, :vi)).to eq("mười lăm")
      expect(Num2words.to_words(20, :vi)).to eq("hai mươi")
      expect(Num2words.to_words(21, :vi)).to eq("hai mươi mốt")
      expect(Num2words.to_words(24, :vi)).to eq("hai mươi tư")
      expect(Num2words.to_words(35, :vi)).to eq("ba mươi lăm")
      expect(Num2words.to_words(99, :vi)).to eq("chín mươi chín")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :vi)).to eq("một trăm")
      expect(Num2words.to_words(101, :vi)).to eq("một trăm linh một")
      expect(Num2words.to_words(105, :vi)).to eq("một trăm linh năm")
      expect(Num2words.to_words(124, :vi)).to eq("một trăm hai mươi tư")
      expect(Num2words.to_words(999, :vi)).to eq("chín trăm chín mươi chín")
    end
  end

  context "thousands and scales" do
    it "converts thousands with full lower groups" do
      expect(Num2words.to_words(1_000, :vi)).to eq("một nghìn")
      expect(Num2words.to_words(2_000, :vi)).to eq("hai nghìn")
      expect(Num2words.to_words(5_000, :vi)).to eq("năm nghìn")
      expect(Num2words.to_words(21_000, :vi)).to eq("hai mươi mốt nghìn")
      expect(Num2words.to_words(22_000, :vi)).to eq("hai mươi hai nghìn")
      expect(Num2words.to_words(25_000, :vi)).to eq("hai mươi lăm nghìn")
      expect(Num2words.to_words(1_001, :vi)).to eq("một nghìn không trăm linh một")
      expect(Num2words.to_words(2_002, :vi)).to eq("hai nghìn không trăm linh hai")
      expect(Num2words.to_words(5_005, :vi)).to eq("năm nghìn không trăm linh năm")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :vi)).to eq("một triệu")
      expect(Num2words.to_words(2_000_000, :vi)).to eq("hai triệu")
      expect(Num2words.to_words(5_000_000, :vi)).to eq("năm triệu")
      expect(Num2words.to_words(1_000_000_000, :vi)).to eq("một tỷ")
      expect(Num2words.to_words(2_000_000_000, :vi)).to eq("hai tỷ")
      expect(Num2words.to_words(5_000_000_000, :vi)).to eq("năm tỷ")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :vi)).to eq("một triệu hai trăm ba mươi tư nghìn năm trăm sáu mươi bảy")
      expect(Num2words.to_words(1_000_001, :vi)).to eq("một triệu không trăm linh một")
      expect(Num2words.to_words(2_021_004, :vi)).to eq("hai triệu không trăm hai mươi mốt nghìn không trăm linh bốn")
    end
  end

  context "feminine option" do
    it "does not change Vietnamese output" do
      expect(Num2words.to_words(1, :vi, feminine: true)).to eq("một")
      expect(Num2words.to_words(2, :vi, feminine: true)).to eq("hai")
      expect(Num2words.to_words(21, :vi, feminine: true)).to eq("hai mươi mốt")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :vi)).to eq("âm một")
      expect(Num2words.to_words(-21, :vi)).to eq("âm hai mươi mốt")
      expect(Num2words.to_words(-1_000, :vi)).to eq("âm một nghìn")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :vi)).to eq("bảy")
      expect(Num2words.to_words("-42", :vi)).to eq("âm bốn mươi hai")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :vi)).to eq("ba phẩy năm phần mười")
      expect(Num2words.to_words("3,5", :vi)).to eq("ba phẩy năm phần mười")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :vi)).to eq("không phẩy năm phần mười")
      expect(Num2words.to_words(2.25, :vi)).to eq("hai phẩy hai mươi lăm phần trăm")
      expect(Num2words.to_words(3.01, :vi)).to eq("ba phẩy một phần trăm")
      expect(Num2words.to_words(-1.2, :vi)).to eq("âm một phẩy hai phần mười")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :vi, joiner: :and)).to eq("không và năm phần mười")
      expect(Num2words.to_words(12.12, :vi, style: :decimal)).to eq("mười hai phẩy một hai")
      expect(Num2words.to_words("3,05", :vi, style: :decimal)).to eq("ba phẩy không năm")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :vi)).to eq(
        "chín tỷ tám trăm bảy mươi sáu triệu năm trăm bốn mươi ba nghìn hai trăm mười"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :vi)).to eq("mười một nghìn không trăm mười một")
      expect(Num2words.to_words(1_011_011, :vi)).to eq("một triệu không trăm mười một nghìn không trăm mười một")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "hai mươi mốt"
      expect(Num2words.to_words(21, :vi, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :vi, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :vi, word_case: :capitalize)).to eq("Hai mươi mốt")
      expect(Num2words.to_words(21, :vi, word_case: :title)).to eq("Hai Mươi Mốt")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :vi)).to eq("một đồng không hào")
      expect(Num2words.to_currency(2, :vi)).to eq("hai đồng không hào")
      expect(Num2words.to_currency("12.50", :vi)).to eq("mười hai đồng năm mươi hào")
      expect(Num2words.to_currency("12.50", :vi, code: :BRL)).to eq("mười hai real brazil năm mươi centavo")
      expect(Num2words.to_currency(12, :vi, minor: :nonzero)).to eq("mười hai đồng")
      expect(Num2words.to_currency(12.5, :vi, minor: :never)).to eq("mười hai đồng")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :vi)).to eq("hai mươi mốt tháng tám năm hai nghìn không trăm hai mươi tư")
      expect(Num2words.to_words("14:35:42", :vi)).to eq("mười bốn giờ ba mươi lăm phút bốn mươi hai giây")
      expect(Num2words.to_words("2024-08-21 14:35:42", :vi)).to eq(
        "hai mươi mốt tháng tám năm hai nghìn không trăm hai mươi tư, mười bốn giờ ba mươi lăm phút bốn mươi hai giây"
      )
    end
  end
end
