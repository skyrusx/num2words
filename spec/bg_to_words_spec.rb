# frozen_string_literal: true

require "num2words"

RSpec.describe "Bulgarian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :bg)).to eq("нула")
      expect(Num2words.to_words(1, :bg)).to eq("един")
      expect(Num2words.to_words(2, :bg)).to eq("два")
      expect(Num2words.to_words(5, :bg)).to eq("пет")
    end

    it "converts tens and teens with Bulgarian conjunctions" do
      expect(Num2words.to_words(10, :bg)).to eq("десет")
      expect(Num2words.to_words(11, :bg)).to eq("единадесет")
      expect(Num2words.to_words(19, :bg)).to eq("деветнадесет")
      expect(Num2words.to_words(20, :bg)).to eq("двадесет")
      expect(Num2words.to_words(21, :bg)).to eq("двадесет и един")
      expect(Num2words.to_words(24, :bg)).to eq("двадесет и четири")
      expect(Num2words.to_words(35, :bg)).to eq("тридесет и пет")
      expect(Num2words.to_words(99, :bg)).to eq("деветдесет и девет")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :bg)).to eq("сто")
      expect(Num2words.to_words(101, :bg)).to eq("сто и един")
      expect(Num2words.to_words(105, :bg)).to eq("сто и пет")
      expect(Num2words.to_words(124, :bg)).to eq("сто двадесет и четири")
      expect(Num2words.to_words(999, :bg)).to eq("деветстотин деветдесет и девет")
    end
  end

  context "thousands" do
    it "uses feminine forms and thousand-specific wording" do
      expect(Num2words.to_words(1_000, :bg)).to eq("хиляда")
      expect(Num2words.to_words(2_000, :bg)).to eq("две хиляди")
      expect(Num2words.to_words(5_000, :bg)).to eq("пет хиляди")
      expect(Num2words.to_words(21_000, :bg)).to eq("двадесет и една хиляди")
      expect(Num2words.to_words(22_000, :bg)).to eq("двадесет и две хиляди")
      expect(Num2words.to_words(25_000, :bg)).to eq("двадесет и пет хиляди")
      expect(Num2words.to_words(1_001, :bg)).to eq("хиляда и един")
      expect(Num2words.to_words(2_002, :bg)).to eq("две хиляди и два")
      expect(Num2words.to_words(5_005, :bg)).to eq("пет хиляди и пет")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :bg)).to eq("един милион")
      expect(Num2words.to_words(2_000_000, :bg)).to eq("два милиона")
      expect(Num2words.to_words(5_000_000, :bg)).to eq("пет милиона")
      expect(Num2words.to_words(1_000_000_000, :bg)).to eq("един милиард")
      expect(Num2words.to_words(2_000_000_000, :bg)).to eq("два милиарда")
      expect(Num2words.to_words(5_000_000_000, :bg)).to eq("пет милиарда")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :bg)).to eq("един милион двеста тридесет и четири хиляди петстотин шестдесет и седем")
      expect(Num2words.to_words(1_000_001, :bg)).to eq("един милион и един")
      expect(Num2words.to_words(2_021_004, :bg)).to eq("два милиона двадесет и една хиляди и четири")
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :bg, feminine: true)).to eq("една")
      expect(Num2words.to_words(2, :bg, feminine: true)).to eq("две")
      expect(Num2words.to_words(21, :bg, feminine: true)).to eq("двадесет и една")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :bg)).to eq("минус един")
      expect(Num2words.to_words(-21, :bg)).to eq("минус двадесет и един")
      expect(Num2words.to_words(-1_000, :bg)).to eq("минус хиляда")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :bg)).to eq("седем")
      expect(Num2words.to_words("-42", :bg)).to eq("минус четиридесет и два")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :bg)).to eq("три цяло пет десети")
      expect(Num2words.to_words("3,5", :bg)).to eq("три цяло пет десети")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :bg)).to eq("нула цяло пет десети")
      expect(Num2words.to_words(2.25, :bg)).to eq("два цяло двадесет и пет стотни")
      expect(Num2words.to_words(3.01, :bg)).to eq("три цяло една стотна")
      expect(Num2words.to_words(-1.2, :bg)).to eq("минус един цяло две десети")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :bg, joiner: :and)).to eq("нула и пет десети")
      expect(Num2words.to_words(2.25, :bg, joiner: :and)).to eq("два и двадесет и пет стотни")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :bg)).to eq(
        "девет милиарда осемстотин седемдесет и шест милиона петстотин четиридесет и три хиляди двеста и десет"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :bg)).to eq("единадесет хиляди и единадесет")
      expect(Num2words.to_words(1_011_011, :bg)).to eq("един милион единадесет хиляди и единадесет")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "двадесет и един"
      expect(Num2words.to_words(21, :bg, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :bg, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :bg, word_case: :capitalize)).to eq("Двадесет и един")
      expect(Num2words.to_words(21, :bg, word_case: :title)).to eq("Двадесет И Един")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :bg)).to eq("един лев нула стотинки")
      expect(Num2words.to_currency(2, :bg)).to eq("два лева нула стотинки")
      expect(Num2words.to_currency("12.50", :bg)).to eq("дванадесет лева петдесет стотинки")
      expect(Num2words.to_currency("12.50", :bg, code: :BRL)).to eq("дванадесет бразилски реала петдесет сентаво")
      expect(Num2words.to_currency(12, :bg, minor: :nonzero)).to eq("дванадесет лева")
      expect(Num2words.to_currency(12.5, :bg, minor: :never)).to eq("дванадесет лева")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :bg)).to eq("двадесет и първо август две хиляди двадесет и четвърти година")
      expect(Num2words.to_words("2024-08-21", :bg, date_case: :genitive)).to eq("двадесет и първи август две хиляди двадесет и четвърти година")
      expect(Num2words.to_words("14:35:42", :bg)).to eq("четиринадесет часа тридесет и пет минути четиридесет и две секунди")
      expect(Num2words.to_words("2024-08-21 14:35:42", :bg)).to eq(
        "двадесет и първо август две хиляди двадесет и четвърти година, четиринадесет часа тридесет и пет минути четиридесет и две секунди"
      )
    end
  end
end
