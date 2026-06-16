# frozen_string_literal: true

require "num2words"

RSpec.describe "Slovak locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :sk)).to eq("nula")
      expect(Num2words.to_words(1, :sk)).to eq("jeden")
      expect(Num2words.to_words(2, :sk)).to eq("dva")
      expect(Num2words.to_words(5, :sk)).to eq("päť")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :sk)).to eq("desať")
      expect(Num2words.to_words(11, :sk)).to eq("jedenásť")
      expect(Num2words.to_words(19, :sk)).to eq("devätnásť")
      expect(Num2words.to_words(20, :sk)).to eq("dvadsať")
      expect(Num2words.to_words(21, :sk)).to eq("dvadsať jeden")
      expect(Num2words.to_words(24, :sk)).to eq("dvadsať štyri")
      expect(Num2words.to_words(35, :sk)).to eq("tridsať päť")
      expect(Num2words.to_words(99, :sk)).to eq("deväťdesiat deväť")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :sk)).to eq("sto")
      expect(Num2words.to_words(101, :sk)).to eq("sto jeden")
      expect(Num2words.to_words(105, :sk)).to eq("sto päť")
      expect(Num2words.to_words(124, :sk)).to eq("sto dvadsať štyri")
      expect(Num2words.to_words(999, :sk)).to eq("deväťsto deväťdesiat deväť")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :sk)).to eq("tisíc")
      expect(Num2words.to_words(2_000, :sk)).to eq("dva tisíce")
      expect(Num2words.to_words(5_000, :sk)).to eq("päť tisíc")
      expect(Num2words.to_words(21_000, :sk)).to eq("dvadsať jeden tisíc")
      expect(Num2words.to_words(22_000, :sk)).to eq("dvadsať dva tisíce")
      expect(Num2words.to_words(25_000, :sk)).to eq("dvadsať päť tisíc")
      expect(Num2words.to_words(1_001, :sk)).to eq("tisíc jeden")
      expect(Num2words.to_words(2_002, :sk)).to eq("dva tisíce dva")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :sk)).to eq("jeden milión")
      expect(Num2words.to_words(2_000_000, :sk)).to eq("dva milióny")
      expect(Num2words.to_words(5_000_000, :sk)).to eq("päť miliónov")
      expect(Num2words.to_words(1_000_000_000, :sk)).to eq("jedna miliarda")
      expect(Num2words.to_words(2_000_000_000, :sk)).to eq("dve miliardy")
      expect(Num2words.to_words(1_234_567, :sk)).to eq("jeden milión dvesto tridsať štyri tisíce päťsto šesťdesiat sedem")
      expect(Num2words.to_words(9_876_543_210, :sk)).to eq(
        "deväť miliárd osemsto sedemdesiat šesť miliónov päťsto štyridsať tri tisíce dvesto desať"
      )
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :sk, feminine: true)).to eq("jedna")
      expect(Num2words.to_words(2, :sk, feminine: true)).to eq("dve")
      expect(Num2words.to_words(21, :sk, feminine: true)).to eq("dvadsať jedna")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :sk)).to eq("mínus jeden")
      expect(Num2words.to_words(-21, :sk)).to eq("mínus dvadsať jeden")
      expect(Num2words.to_words("-42", :sk)).to eq("mínus štyridsať dva")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :sk)).to eq("tri celých päť desatín")
      expect(Num2words.to_words("3,5", :sk)).to eq("tri celých päť desatín")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :sk)).to eq("nula celých päť desatín")
      expect(Num2words.to_words(2.25, :sk)).to eq("dva celých dvadsať päť stotín")
      expect(Num2words.to_words(3.01, :sk)).to eq("tri celých jedna stotina")
      expect(Num2words.to_words(-1.2, :sk)).to eq("mínus jeden celých dve desatiny")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :sk, joiner: :and)).to eq("nula a päť desatín")
      expect(Num2words.to_words(12.12, :sk, style: :decimal)).to eq("dvanásť čiarka jeden dva")
      expect(Num2words.to_words("3,05", :sk, style: :decimal)).to eq("tri čiarka nula päť")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :sk)).to eq("jeden euro nula centov")
      expect(Num2words.to_currency(2, :sk)).to eq("dva eurá nula centov")
      expect(Num2words.to_currency("12.50", :sk)).to eq("dvanásť eur päťdesiat centov")
      expect(Num2words.to_currency("12.50", :sk, code: :BRL)).to eq("dvanásť brazílskych realov päťdesiat centavov")
      expect(Num2words.to_currency(12, :sk, minor: :nonzero)).to eq("dvanásť eur")
      expect(Num2words.to_currency(12.5, :sk, minor: :never)).to eq("dvanásť eur")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :sk)).to eq("dvadsiateho prvého augusta dva tisíce dvadsať štyri")
      expect(Num2words.to_words("14:35:42", :sk)).to eq("štrnásť hodín tridsať päť minút štyridsať dve sekundy")
      expect(Num2words.to_words("2024-08-21 14:35:42", :sk)).to eq(
        "dvadsiateho prvého augusta dva tisíce dvadsať štyri, štrnásť hodín tridsať päť minút štyridsať dve sekundy"
      )
    end
  end
end
