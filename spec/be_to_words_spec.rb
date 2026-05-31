# frozen_string_literal: true

require "num2words"

RSpec.describe "Belarusian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :be)).to eq("нуль")
      expect(Num2words.to_words(1, :be)).to eq("адзін")
      expect(Num2words.to_words(2, :be)).to eq("два")
      expect(Num2words.to_words(5, :be)).to eq("пяць")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :be)).to eq("дзесяць")
      expect(Num2words.to_words(11, :be)).to eq("адзінаццаць")
      expect(Num2words.to_words(19, :be)).to eq("дзевятнаццаць")
      expect(Num2words.to_words(20, :be)).to eq("дваццаць")
      expect(Num2words.to_words(21, :be)).to eq("дваццаць адзін")
      expect(Num2words.to_words(24, :be)).to eq("дваццаць чатыры")
      expect(Num2words.to_words(35, :be)).to eq("трыццаць пяць")
      expect(Num2words.to_words(99, :be)).to eq("дзевяноста дзевяць")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :be)).to eq("сто")
      expect(Num2words.to_words(101, :be)).to eq("сто адзін")
      expect(Num2words.to_words(105, :be)).to eq("сто пяць")
      expect(Num2words.to_words(124, :be)).to eq("сто дваццаць чатыры")
      expect(Num2words.to_words(999, :be)).to eq("дзевяцьсот дзевяноста дзевяць")
    end
  end

  context "thousands" do
    it "uses feminine forms for the thousand group" do
      expect(Num2words.to_words(1_000, :be)).to eq("адна тысяча")
      expect(Num2words.to_words(2_000, :be)).to eq("дзве тысячы")
      expect(Num2words.to_words(5_000, :be)).to eq("пяць тысяч")
      expect(Num2words.to_words(21_000, :be)).to eq("дваццаць адна тысяча")
      expect(Num2words.to_words(22_000, :be)).to eq("дваццаць дзве тысячы")
      expect(Num2words.to_words(25_000, :be)).to eq("дваццаць пяць тысяч")
      expect(Num2words.to_words(1_001, :be)).to eq("адна тысяча адзін")
      expect(Num2words.to_words(2_002, :be)).to eq("дзве тысячы два")
      expect(Num2words.to_words(5_005, :be)).to eq("пяць тысяч пяць")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :be)).to eq("адзін мільён")
      expect(Num2words.to_words(2_000_000, :be)).to eq("два мільёны")
      expect(Num2words.to_words(5_000_000, :be)).to eq("пяць мільёнаў")
      expect(Num2words.to_words(1_000_000_000, :be)).to eq("адзін мільярд")
      expect(Num2words.to_words(2_000_000_000, :be)).to eq("два мільярды")
      expect(Num2words.to_words(5_000_000_000, :be)).to eq("пяць мільярдаў")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :be)).to eq("адзін мільён дзвесце трыццаць чатыры тысячы пяцьсот шэсцьдзесят сем")
      expect(Num2words.to_words(1_000_001, :be)).to eq("адзін мільён адзін")
      expect(Num2words.to_words(2_021_004, :be)).to eq("два мільёны дваццаць адна тысяча чатыры")
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :be, feminine: true)).to eq("адна")
      expect(Num2words.to_words(2, :be, feminine: true)).to eq("дзве")
      expect(Num2words.to_words(21, :be, feminine: true)).to eq("дваццаць адна")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :be)).to eq("мінус адзін")
      expect(Num2words.to_words(-21, :be)).to eq("мінус дваццаць адзін")
      expect(Num2words.to_words(-1_000, :be)).to eq("мінус адна тысяча")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :be)).to eq("сем")
      expect(Num2words.to_words("-42", :be)).to eq("мінус сорак два")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :be)).to eq("тры цэлых пяць дзясятых")
      expect(Num2words.to_words("3,5", :be)).to eq("тры цэлых пяць дзясятых")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :be)).to eq("нуль цэлых пяць дзясятых")
      expect(Num2words.to_words(2.25, :be)).to eq("два цэлых дваццаць пяць сотых")
      expect(Num2words.to_words(3.01, :be)).to eq("тры цэлых адна сотая")
      expect(Num2words.to_words(-1.2, :be)).to eq("мінус адзін цэлых дзве дзясятыя")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :be, joiner: :and)).to eq("нуль і пяць дзясятых")
      expect(Num2words.to_words(2.25, :be, joiner: :and)).to eq("два і дваццаць пяць сотых")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :be)).to eq(
        "дзевяць мільярдаў восемсот семдзесят шэсць мільёнаў пяцьсот сорак тры тысячы дзвесце дзесяць"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :be)).to eq("адзінаццаць тысяч адзінаццаць")
      expect(Num2words.to_words(1_011_011, :be)).to eq("адзін мільён адзінаццаць тысяч адзінаццаць")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "дваццаць адзін"
      expect(Num2words.to_words(21, :be, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :be, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :be, word_case: :capitalize)).to eq("Дваццаць адзін")
      expect(Num2words.to_words(21, :be, word_case: :title)).to eq("Дваццаць Адзін")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :be)).to eq("адзін беларускі рубель нуль капе́ек")
      expect(Num2words.to_currency(2, :be)).to eq("два беларускія рублі нуль капе́ек")
      expect(Num2words.to_currency("12.50", :be)).to eq("дванаццаць беларускіх рублёў пяцьдзесят капе́ек")
      expect(Num2words.to_currency("12.50", :be, code: :BRL)).to eq("дванаццаць бразільскіх рэалаў пяцьдзесят сентава")
      expect(Num2words.to_currency(12, :be, minor: :nonzero)).to eq("дванаццаць беларускіх рублёў")
      expect(Num2words.to_currency(12.5, :be, minor: :never)).to eq("дванаццаць беларускіх рублёў")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :be)).to eq("дваццаць першае жніўня дзве тысячы дваццаць чацвёртага года")
      expect(Num2words.to_words("2024-08-21", :be, date_case: :genitive)).to eq("дваццаць першага жніўня дзве тысячы дваццаць чацвёртага года")
      expect(Num2words.to_words("14:35:42", :be)).to eq("чатырнаццаць гадзін трыццаць пяць хвілін сорак дзве секунды")
      expect(Num2words.to_words("2024-08-21 14:35:42", :be)).to eq(
        "дваццаць першае жніўня дзве тысячы дваццаць чацвёртага года, чатырнаццаць гадзін трыццаць пяць хвілін сорак дзве секунды"
      )
    end
  end
end
