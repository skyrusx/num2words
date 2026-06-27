# frozen_string_literal: true

require "num2words"

RSpec.describe "Turkish locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :tr)).to eq("sıfır")
      expect(Num2words.to_words(1, :tr)).to eq("bir")
      expect(Num2words.to_words(2, :tr)).to eq("iki")
      expect(Num2words.to_words(5, :tr)).to eq("beş")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :tr)).to eq("on")
      expect(Num2words.to_words(11, :tr)).to eq("on bir")
      expect(Num2words.to_words(19, :tr)).to eq("on dokuz")
      expect(Num2words.to_words(20, :tr)).to eq("yirmi")
      expect(Num2words.to_words(21, :tr)).to eq("yirmi bir")
      expect(Num2words.to_words(24, :tr)).to eq("yirmi dört")
      expect(Num2words.to_words(35, :tr)).to eq("otuz beş")
      expect(Num2words.to_words(99, :tr)).to eq("doksan dokuz")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :tr)).to eq("yüz")
      expect(Num2words.to_words(101, :tr)).to eq("yüz bir")
      expect(Num2words.to_words(105, :tr)).to eq("yüz beş")
      expect(Num2words.to_words(124, :tr)).to eq("yüz yirmi dört")
      expect(Num2words.to_words(999, :tr)).to eq("dokuz yüz doksan dokuz")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :tr)).to eq("bin")
      expect(Num2words.to_words(2_000, :tr)).to eq("iki bin")
      expect(Num2words.to_words(5_000, :tr)).to eq("beş bin")
      expect(Num2words.to_words(21_000, :tr)).to eq("yirmi bir bin")
      expect(Num2words.to_words(1_001, :tr)).to eq("bin bir")
      expect(Num2words.to_words(2_002, :tr)).to eq("iki bin iki")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :tr)).to eq("bir milyon")
      expect(Num2words.to_words(2_000_000, :tr)).to eq("iki milyon")
      expect(Num2words.to_words(1_234_567, :tr)).to eq("bir milyon iki yüz otuz dört bin beş yüz altmış yedi")
      expect(Num2words.to_words(9_876_543_210, :tr)).to eq(
        "dokuz milyar sekiz yüz yetmiş altı milyon beş yüz kırk üç bin iki yüz on"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :tr)).to eq("eksi bir")
      expect(Num2words.to_words(-21, :tr)).to eq("eksi yirmi bir")
      expect(Num2words.to_words("-42", :tr)).to eq("eksi kırk iki")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :tr)).to eq("üç tam beş onda bir")
      expect(Num2words.to_words("3,5", :tr)).to eq("üç tam beş onda bir")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :tr)).to eq("sıfır tam beş onda bir")
      expect(Num2words.to_words(2.25, :tr)).to eq("iki tam yirmi beş yüzde bir")
      expect(Num2words.to_words(3.01, :tr)).to eq("üç tam bir yüzde bir")
      expect(Num2words.to_words(-1.2, :tr)).to eq("eksi bir tam iki onda bir")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :tr, joiner: :and)).to eq("sıfır ve beş onda bir")
      expect(Num2words.to_words(12.12, :tr, style: :decimal)).to eq("on iki virgül bir iki")
      expect(Num2words.to_words("3,05", :tr, style: :decimal)).to eq("üç virgül sıfır beş")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :tr)).to eq("bir lira sıfır kuruş")
      expect(Num2words.to_currency(2, :tr)).to eq("iki lira sıfır kuruş")
      expect(Num2words.to_currency("12.50", :tr)).to eq("on iki lira elli kuruş")
      expect(Num2words.to_currency("12.50", :tr, code: :BRL)).to eq("on iki brezilya reali elli centavo")
      expect(Num2words.to_currency(12, :tr, minor: :nonzero)).to eq("on iki lira")
      expect(Num2words.to_currency(12.5, :tr, minor: :never)).to eq("on iki lira")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :tr)).to eq("yirmi birinci Ağustos iki bin yirmi dört")
      expect(Num2words.to_words("14:35:42", :tr)).to eq("on dört saat otuz beş dakika kırk iki saniye")
      expect(Num2words.to_words("2024-08-21 14:35:42", :tr)).to eq(
        "yirmi birinci Ağustos iki bin yirmi dört, on dört saat otuz beş dakika kırk iki saniye"
      )
    end
  end
end
