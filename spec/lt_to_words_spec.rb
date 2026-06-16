# frozen_string_literal: true

require "num2words"

RSpec.describe "Lithuanian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :lt)).to eq("nulis")
      expect(Num2words.to_words(1, :lt)).to eq("vienas")
      expect(Num2words.to_words(2, :lt)).to eq("du")
      expect(Num2words.to_words(5, :lt)).to eq("penki")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :lt)).to eq("dešimt")
      expect(Num2words.to_words(11, :lt)).to eq("vienuolika")
      expect(Num2words.to_words(19, :lt)).to eq("devyniolika")
      expect(Num2words.to_words(20, :lt)).to eq("dvidešimt")
      expect(Num2words.to_words(21, :lt)).to eq("dvidešimt vienas")
      expect(Num2words.to_words(24, :lt)).to eq("dvidešimt keturi")
      expect(Num2words.to_words(35, :lt)).to eq("trisdešimt penki")
      expect(Num2words.to_words(99, :lt)).to eq("devyniasdešimt devyni")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :lt)).to eq("šimtas")
      expect(Num2words.to_words(101, :lt)).to eq("šimtas vienas")
      expect(Num2words.to_words(105, :lt)).to eq("šimtas penki")
      expect(Num2words.to_words(124, :lt)).to eq("šimtas dvidešimt keturi")
      expect(Num2words.to_words(999, :lt)).to eq("devyni šimtai devyniasdešimt devyni")
    end
  end

  context "thousands and large scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :lt)).to eq("vienas tūkstantis")
      expect(Num2words.to_words(2_000, :lt)).to eq("du tūkstančiai")
      expect(Num2words.to_words(5_000, :lt)).to eq("penki tūkstančiai")
      expect(Num2words.to_words(21_000, :lt)).to eq("dvidešimt vienas tūkstantis")
      expect(Num2words.to_words(22_000, :lt)).to eq("dvidešimt du tūkstančiai")
      expect(Num2words.to_words(25_000, :lt)).to eq("dvidešimt penki tūkstančiai")
      expect(Num2words.to_words(11_000, :lt)).to eq("vienuolika tūkstančių")
      expect(Num2words.to_words(1_001, :lt)).to eq("vienas tūkstantis vienas")
      expect(Num2words.to_words(2_002, :lt)).to eq("du tūkstančiai du")
      expect(Num2words.to_words(5_005, :lt)).to eq("penki tūkstančiai penki")
    end

    it "converts million and billion values" do
      expect(Num2words.to_words(1_000_000, :lt)).to eq("vienas milijonas")
      expect(Num2words.to_words(2_000_000, :lt)).to eq("du milijonai")
      expect(Num2words.to_words(5_000_000, :lt)).to eq("penki milijonai")
      expect(Num2words.to_words(11_000_000, :lt)).to eq("vienuolika milijonų")
      expect(Num2words.to_words(1_000_000_000, :lt)).to eq("vienas milijardas")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :lt)).to eq("vienas milijonas du šimtai trisdešimt keturi tūkstančiai penki šimtai šešiasdešimt septyni")
      expect(Num2words.to_words(1_000_001, :lt)).to eq("vienas milijonas vienas")
      expect(Num2words.to_words(2_021_004, :lt)).to eq("du milijonai dvidešimt vienas tūkstantis keturi")
    end
  end

  context "feminine option" do
    it "changes Lithuanian one and two forms" do
      expect(Num2words.to_words(1, :lt, feminine: true)).to eq("viena")
      expect(Num2words.to_words(2, :lt, feminine: true)).to eq("dvi")
      expect(Num2words.to_words(21, :lt, feminine: true)).to eq("dvidešimt viena")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :lt)).to eq("minus vienas")
      expect(Num2words.to_words(-21, :lt)).to eq("minus dvidešimt vienas")
      expect(Num2words.to_words(-1_000, :lt)).to eq("minus vienas tūkstantis")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :lt)).to eq("septyni")
      expect(Num2words.to_words("-42", :lt)).to eq("minus keturiasdešimt du")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :lt)).to eq("trys sveikųjų penkios dešimtosios")
      expect(Num2words.to_words("3,5", :lt)).to eq("trys sveikųjų penkios dešimtosios")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :lt)).to eq("nulis sveikųjų penkios dešimtosios")
      expect(Num2words.to_words(2.25, :lt)).to eq("du sveikųjų dvidešimt penkios šimtosios")
      expect(Num2words.to_words(3.01, :lt)).to eq("trys sveikųjų viena šimtoji")
      expect(Num2words.to_words(-1.2, :lt)).to eq("minus vienas sveikųjų dvi dešimtosios")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :lt, joiner: :and)).to eq("nulis ir penkios dešimtosios")
      expect(Num2words.to_words(12.12, :lt, style: :decimal)).to eq("dvylika kablelis vienas du")
      expect(Num2words.to_words("3,05", :lt, style: :decimal)).to eq("trys kablelis nulis penki")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :lt)).to eq(
        "devyni milijardai aštuoni šimtai septyniasdešimt šeši milijonai penki šimtai keturiasdešimt trys tūkstančiai du šimtai dešimt"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :lt)).to eq("vienuolika tūkstančių vienuolika")
      expect(Num2words.to_words(1_011_011, :lt)).to eq("vienas milijonas vienuolika tūkstančių vienuolika")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "dvidešimt vienas"
      expect(Num2words.to_words(21, :lt, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :lt, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :lt, word_case: :capitalize)).to eq("Dvidešimt vienas")
      expect(Num2words.to_words(21, :lt, word_case: :title)).to eq("Dvidešimt Vienas")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :lt)).to eq("vienas euras nulis centų")
      expect(Num2words.to_currency(2, :lt)).to eq("du eurai nulis centų")
      expect(Num2words.to_currency("12.50", :lt)).to eq("dvylika eurų penkiasdešimt centų")
      expect(Num2words.to_currency("12.50", :lt, code: :BRL)).to eq("dvylika brazilijos realų penkiasdešimt sentavų")
      expect(Num2words.to_currency(12, :lt, minor: :nonzero)).to eq("dvylika eurų")
      expect(Num2words.to_currency(12.5, :lt, minor: :never)).to eq("dvylika eurų")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :lt)).to eq("dvidešimt pirmoji rugpjūčio du tūkstančiai dvidešimt keturi")
      expect(Num2words.to_words("14:35:42", :lt)).to eq("keturiolika valandų trisdešimt penkios minutės keturiasdešimt dvi sekundės")
      expect(Num2words.to_words("2024-08-21 14:35:42", :lt)).to eq(
        "dvidešimt pirmoji rugpjūčio du tūkstančiai dvidešimt keturi, keturiolika valandų trisdešimt penkios minutės keturiasdešimt dvi sekundės"
      )
    end
  end
end
