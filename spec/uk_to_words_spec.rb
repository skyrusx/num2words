# frozen_string_literal: true

require "num2words"

RSpec.describe "Ukrainian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :uk)).to eq("нуль")
      expect(Num2words.to_words(1, :uk)).to eq("один")
      expect(Num2words.to_words(2, :uk)).to eq("два")
      expect(Num2words.to_words(5, :uk)).to eq("п'ять")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :uk)).to eq("десять")
      expect(Num2words.to_words(11, :uk)).to eq("одинадцять")
      expect(Num2words.to_words(19, :uk)).to eq("дев'ятнадцять")
      expect(Num2words.to_words(20, :uk)).to eq("двадцять")
      expect(Num2words.to_words(21, :uk)).to eq("двадцять один")
      expect(Num2words.to_words(24, :uk)).to eq("двадцять чотири")
      expect(Num2words.to_words(35, :uk)).to eq("тридцять п'ять")
      expect(Num2words.to_words(99, :uk)).to eq("дев'яносто дев'ять")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :uk)).to eq("сто")
      expect(Num2words.to_words(101, :uk)).to eq("сто один")
      expect(Num2words.to_words(105, :uk)).to eq("сто п'ять")
      expect(Num2words.to_words(124, :uk)).to eq("сто двадцять чотири")
      expect(Num2words.to_words(999, :uk)).to eq("дев'ятсот дев'яносто дев'ять")
    end
  end

  context "thousands" do
    it "uses feminine forms for the thousand group" do
      expect(Num2words.to_words(1_000, :uk)).to eq("одна тисяча")
      expect(Num2words.to_words(2_000, :uk)).to eq("дві тисячі")
      expect(Num2words.to_words(5_000, :uk)).to eq("п'ять тисяч")
      expect(Num2words.to_words(21_000, :uk)).to eq("двадцять одна тисяча")
      expect(Num2words.to_words(22_000, :uk)).to eq("двадцять дві тисячі")
      expect(Num2words.to_words(25_000, :uk)).to eq("двадцять п'ять тисяч")
      expect(Num2words.to_words(1_001, :uk)).to eq("одна тисяча один")
      expect(Num2words.to_words(2_002, :uk)).to eq("дві тисячі два")
      expect(Num2words.to_words(5_005, :uk)).to eq("п'ять тисяч п'ять")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :uk)).to eq("один мільйон")
      expect(Num2words.to_words(2_000_000, :uk)).to eq("два мільйони")
      expect(Num2words.to_words(5_000_000, :uk)).to eq("п'ять мільйонів")
      expect(Num2words.to_words(1_000_000_000, :uk)).to eq("один мільярд")
      expect(Num2words.to_words(2_000_000_000, :uk)).to eq("два мільярди")
      expect(Num2words.to_words(5_000_000_000, :uk)).to eq("п'ять мільярдів")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :uk)).to eq("один мільйон двісті тридцять чотири тисячі п'ятсот шістдесят сім")
      expect(Num2words.to_words(1_000_001, :uk)).to eq("один мільйон один")
      expect(Num2words.to_words(2_021_004, :uk)).to eq("два мільйони двадцять одна тисяча чотири")
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :uk, feminine: true)).to eq("одна")
      expect(Num2words.to_words(2, :uk, feminine: true)).to eq("дві")
      expect(Num2words.to_words(21, :uk, feminine: true)).to eq("двадцять одна")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :uk)).to eq("мінус один")
      expect(Num2words.to_words(-21, :uk)).to eq("мінус двадцять один")
      expect(Num2words.to_words(-1_000, :uk)).to eq("мінус одна тисяча")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :uk)).to eq("сім")
      expect(Num2words.to_words("-42", :uk)).to eq("мінус сорок два")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :uk)).to eq("три цілих п'ять десятих")
      expect(Num2words.to_words("3,5", :uk)).to eq("три цілих п'ять десятих")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :uk)).to eq("нуль цілих п'ять десятих")
      expect(Num2words.to_words(2.25, :uk)).to eq("два цілих двадцять п'ять сотих")
      expect(Num2words.to_words(3.01, :uk)).to eq("три цілих одна сота")
      expect(Num2words.to_words(-1.2, :uk)).to eq("мінус один цілих дві десяті")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :uk, joiner: :and)).to eq("нуль і п'ять десятих")
      expect(Num2words.to_words(2.25, :uk, joiner: :and)).to eq("два і двадцять п'ять сотих")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :uk)).to eq(
        "дев'ять мільярдів вісімсот сімдесят шість мільйонів п'ятсот сорок три тисячі двісті десять"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :uk)).to eq("одинадцять тисяч одинадцять")
      expect(Num2words.to_words(1_011_011, :uk)).to eq("один мільйон одинадцять тисяч одинадцять")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "двадцять один"
      expect(Num2words.to_words(21, :uk, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :uk, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :uk, word_case: :capitalize)).to eq("Двадцять один")
      expect(Num2words.to_words(21, :uk, word_case: :title)).to eq("Двадцять Один")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :uk)).to eq("одна гривня нуль копійок")
      expect(Num2words.to_currency(2, :uk)).to eq("дві гривні нуль копійок")
      expect(Num2words.to_currency("12.50", :uk)).to eq("дванадцять гривень п'ятдесят копійок")
      expect(Num2words.to_currency("12.50", :uk, code: :BRL)).to eq("дванадцять бразильських реалів п'ятдесят сентаво")
      expect(Num2words.to_currency(12, :uk, minor: :nonzero)).to eq("дванадцять гривень")
      expect(Num2words.to_currency(12.5, :uk, minor: :never)).to eq("дванадцять гривень")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :uk)).to eq("двадцять перше серпня дві тисячі двадцять четвертого року")
      expect(Num2words.to_words("2024-08-21", :uk, date_case: :genitive)).to eq("двадцять першого серпня дві тисячі двадцять четвертого року")
      expect(Num2words.to_words("14:35:42", :uk)).to eq("чотирнадцять годин тридцять п'ять хвилин сорок дві секунди")
      expect(Num2words.to_words("2024-08-21 14:35:42", :uk)).to eq(
        "двадцять перше серпня дві тисячі двадцять четвертого року, чотирнадцять годин тридцять п'ять хвилин сорок дві секунди"
      )
    end
  end
end
