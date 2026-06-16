# frozen_string_literal: true

require "num2words"

RSpec.describe "Polish locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :pl)).to eq("zero")
      expect(Num2words.to_words(1, :pl)).to eq("jeden")
      expect(Num2words.to_words(2, :pl)).to eq("dwa")
      expect(Num2words.to_words(5, :pl)).to eq("pięć")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :pl)).to eq("dziesięć")
      expect(Num2words.to_words(11, :pl)).to eq("jedenaście")
      expect(Num2words.to_words(19, :pl)).to eq("dziewiętnaście")
      expect(Num2words.to_words(20, :pl)).to eq("dwadzieścia")
      expect(Num2words.to_words(21, :pl)).to eq("dwadzieścia jeden")
      expect(Num2words.to_words(24, :pl)).to eq("dwadzieścia cztery")
      expect(Num2words.to_words(35, :pl)).to eq("trzydzieści pięć")
      expect(Num2words.to_words(99, :pl)).to eq("dziewięćdziesiąt dziewięć")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :pl)).to eq("sto")
      expect(Num2words.to_words(101, :pl)).to eq("sto jeden")
      expect(Num2words.to_words(105, :pl)).to eq("sto pięć")
      expect(Num2words.to_words(124, :pl)).to eq("sto dwadzieścia cztery")
      expect(Num2words.to_words(999, :pl)).to eq("dziewięćset dziewięćdziesiąt dziewięć")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :pl)).to eq("tysiąc")
      expect(Num2words.to_words(2_000, :pl)).to eq("dwa tysiące")
      expect(Num2words.to_words(5_000, :pl)).to eq("pięć tysięcy")
      expect(Num2words.to_words(21_000, :pl)).to eq("dwadzieścia jeden tysięcy")
      expect(Num2words.to_words(22_000, :pl)).to eq("dwadzieścia dwa tysiące")
      expect(Num2words.to_words(25_000, :pl)).to eq("dwadzieścia pięć tysięcy")
      expect(Num2words.to_words(1_001, :pl)).to eq("tysiąc jeden")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :pl)).to eq("jeden milion")
      expect(Num2words.to_words(2_000_000, :pl)).to eq("dwa miliony")
      expect(Num2words.to_words(5_000_000, :pl)).to eq("pięć milionów")
      expect(Num2words.to_words(1_234_567, :pl)).to eq(
        "jeden milion dwieście trzydzieści cztery tysiące pięćset sześćdziesiąt siedem"
      )
      expect(Num2words.to_words(9_876_543_210, :pl)).to eq(
        "dziewięć miliardów osiemset siedemdziesiąt sześć milionów pięćset czterdzieści trzy tysiące dwieście dziesięć"
      )
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :pl, feminine: true)).to eq("jedna")
      expect(Num2words.to_words(2, :pl, feminine: true)).to eq("dwie")
      expect(Num2words.to_words(21, :pl, feminine: true)).to eq("dwadzieścia jedna")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :pl)).to eq("minus jeden")
      expect(Num2words.to_words(-21, :pl)).to eq("minus dwadzieścia jeden")
      expect(Num2words.to_words("-42", :pl)).to eq("minus czterdzieści dwa")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :pl)).to eq("trzy całych pięć dziesiątych")
      expect(Num2words.to_words("3,5", :pl)).to eq("trzy całych pięć dziesiątych")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :pl)).to eq("zero całych pięć dziesiątych")
      expect(Num2words.to_words(2.25, :pl)).to eq("dwa całych dwadzieścia pięć setnych")
      expect(Num2words.to_words(3.01, :pl)).to eq("trzy całych jedna setna")
      expect(Num2words.to_words(-1.2, :pl)).to eq("minus jeden całych dwie dziesiąte")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :pl, joiner: :and)).to eq("zero i pięć dziesiątych")
      expect(Num2words.to_words(12.12, :pl, style: :decimal)).to eq("dwanaście przecinek jeden dwa")
      expect(Num2words.to_words("3,05", :pl, style: :decimal)).to eq("trzy przecinek zero pięć")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :pl)).to eq("jeden złoty zero groszy")
      expect(Num2words.to_currency(2, :pl)).to eq("dwa złote zero groszy")
      expect(Num2words.to_currency("12.50", :pl)).to eq("dwanaście złotych pięćdziesiąt groszy")
      expect(Num2words.to_currency("12.50", :pl, code: :BRL)).to eq("dwanaście reali brazylijskich pięćdziesiąt centavo")
      expect(Num2words.to_currency(12, :pl, minor: :nonzero)).to eq("dwanaście złotych")
      expect(Num2words.to_currency(12.5, :pl, minor: :never)).to eq("dwanaście złotych")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :pl)).to eq("dwudziestego pierwszego sierpnia dwa tysiące dwudziestego czwartego roku")
      expect(Num2words.to_words("14:35:42", :pl)).to eq("czternaście godzin trzydzieści pięć minut czterdzieści dwie sekundy")
      expect(Num2words.to_words("2024-08-21 14:35:42", :pl)).to eq(
        "dwudziestego pierwszego sierpnia dwa tysiące dwudziestego czwartego roku, czternaście godzin trzydzieści pięć minut czterdzieści dwie sekundy"
      )
    end
  end
end
