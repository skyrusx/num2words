# frozen_string_literal: true

require "num2words"

RSpec.describe "Serbian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :sr)).to eq("нула")
      expect(Num2words.to_words(1, :sr)).to eq("један")
      expect(Num2words.to_words(2, :sr)).to eq("два")
      expect(Num2words.to_words(5, :sr)).to eq("пет")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :sr)).to eq("десет")
      expect(Num2words.to_words(11, :sr)).to eq("једанаест")
      expect(Num2words.to_words(19, :sr)).to eq("деветнаест")
      expect(Num2words.to_words(20, :sr)).to eq("двадесет")
      expect(Num2words.to_words(21, :sr)).to eq("двадесет један")
      expect(Num2words.to_words(24, :sr)).to eq("двадесет четири")
      expect(Num2words.to_words(35, :sr)).to eq("тридесет пет")
      expect(Num2words.to_words(99, :sr)).to eq("деведесет девет")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :sr)).to eq("сто")
      expect(Num2words.to_words(101, :sr)).to eq("сто један")
      expect(Num2words.to_words(105, :sr)).to eq("сто пет")
      expect(Num2words.to_words(124, :sr)).to eq("сто двадесет четири")
      expect(Num2words.to_words(999, :sr)).to eq("деветсто деведесет девет")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :sr)).to eq("једна хиљада")
      expect(Num2words.to_words(2_000, :sr)).to eq("две хиљаде")
      expect(Num2words.to_words(5_000, :sr)).to eq("пет хиљада")
      expect(Num2words.to_words(21_000, :sr)).to eq("двадесет једна хиљада")
      expect(Num2words.to_words(22_000, :sr)).to eq("двадесет две хиљаде")
      expect(Num2words.to_words(1_001, :sr)).to eq("једна хиљада један")
      expect(Num2words.to_words(2_002, :sr)).to eq("две хиљаде два")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :sr)).to eq("један милион")
      expect(Num2words.to_words(2_000_000, :sr)).to eq("два милиона")
      expect(Num2words.to_words(5_000_000, :sr)).to eq("пет милиона")
      expect(Num2words.to_words(1_000_000_000, :sr)).to eq("једна милијарда")
      expect(Num2words.to_words(2_000_000_000, :sr)).to eq("две милијарде")
      expect(Num2words.to_words(1_234_567, :sr)).to eq("један милион двеста тридесет четири хиљаде петсто шездесет седам")
      expect(Num2words.to_words(9_876_543_210, :sr)).to eq(
        "девет милијарди осамсто седамдесет шест милиона петсто четрдесет три хиљаде двеста десет"
      )
    end
  end

  context "feminine option" do
    it "uses feminine forms" do
      expect(Num2words.to_words(1, :sr, feminine: true)).to eq("једна")
      expect(Num2words.to_words(2, :sr, feminine: true)).to eq("две")
      expect(Num2words.to_words(21, :sr, feminine: true)).to eq("двадесет једна")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :sr)).to eq("минус један")
      expect(Num2words.to_words(-21, :sr)).to eq("минус двадесет један")
      expect(Num2words.to_words("-42", :sr)).to eq("минус четрдесет два")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :sr)).to eq("три целих пет десетина")
      expect(Num2words.to_words("3,5", :sr)).to eq("три целих пет десетина")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :sr)).to eq("нула целих пет десетина")
      expect(Num2words.to_words(2.25, :sr)).to eq("два целих двадесет пет стотина")
      expect(Num2words.to_words(3.01, :sr)).to eq("три целих једна стотина")
      expect(Num2words.to_words(-1.2, :sr)).to eq("минус један целих две десетине")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :sr, joiner: :and)).to eq("нула и пет десетина")
      expect(Num2words.to_words(12.12, :sr, style: :decimal)).to eq("дванаест зарез један два")
      expect(Num2words.to_words("3,05", :sr, style: :decimal)).to eq("три зарез нула пет")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :sr)).to eq("један динар нула пара")
      expect(Num2words.to_currency(2, :sr)).to eq("два динара нула пара")
      expect(Num2words.to_currency("12.50", :sr)).to eq("дванаест динара педесет пара")
      expect(Num2words.to_currency("12.50", :sr, code: :BRL)).to eq("дванаест бразилских реала педесет сентава")
      expect(Num2words.to_currency(12, :sr, minor: :nonzero)).to eq("дванаест динара")
      expect(Num2words.to_currency(12.5, :sr, minor: :never)).to eq("дванаест динара")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :sr)).to eq("двадесет првог августа две хиљаде двадесет четири")
      expect(Num2words.to_words("14:35:42", :sr)).to eq("четрнаест сати тридесет пет минута четрдесет две секунде")
      expect(Num2words.to_words("2024-08-21 14:35:42", :sr)).to eq(
        "двадесет првог августа две хиљаде двадесет четири, четрнаест сати тридесет пет минута четрдесет две секунде"
      )
    end
  end
end
