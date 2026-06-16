# frozen_string_literal: true

require "num2words"

RSpec.describe "Slovenian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :sl)).to eq("nič")
      expect(Num2words.to_words(1, :sl)).to eq("en")
      expect(Num2words.to_words(2, :sl)).to eq("dva")
      expect(Num2words.to_words(5, :sl)).to eq("pet")
    end

    it "converts Slovenian-specific tens and teens" do
      expect(Num2words.to_words(10, :sl)).to eq("deset")
      expect(Num2words.to_words(11, :sl)).to eq("enajst")
      expect(Num2words.to_words(19, :sl)).to eq("devetnajst")
      expect(Num2words.to_words(20, :sl)).to eq("dvajset")
      expect(Num2words.to_words(21, :sl)).to eq("enaindvajset")
      expect(Num2words.to_words(24, :sl)).to eq("štiriindvajset")
      expect(Num2words.to_words(35, :sl)).to eq("petintrideset")
      expect(Num2words.to_words(99, :sl)).to eq("devetindevetdeset")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :sl)).to eq("sto")
      expect(Num2words.to_words(101, :sl)).to eq("sto en")
      expect(Num2words.to_words(105, :sl)).to eq("sto pet")
      expect(Num2words.to_words(124, :sl)).to eq("sto štiriindvajset")
      expect(Num2words.to_words(999, :sl)).to eq("devetsto devetindevetdeset")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :sl)).to eq("tisoč")
      expect(Num2words.to_words(2_000, :sl)).to eq("dva tisoč")
      expect(Num2words.to_words(5_000, :sl)).to eq("pet tisoč")
      expect(Num2words.to_words(21_000, :sl)).to eq("enaindvajset tisoč")
      expect(Num2words.to_words(1_001, :sl)).to eq("tisoč en")
      expect(Num2words.to_words(2_002, :sl)).to eq("dva tisoč dva")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :sl)).to eq("en milijon")
      expect(Num2words.to_words(2_000_000, :sl)).to eq("dva milijona")
      expect(Num2words.to_words(5_000_000, :sl)).to eq("pet milijonov")
      expect(Num2words.to_words(1_000_000_000, :sl)).to eq("ena milijarda")
      expect(Num2words.to_words(2_000_000_000, :sl)).to eq("dve milijardi")
      expect(Num2words.to_words(1_234_567, :sl)).to eq("en milijon dvesto štiriintrideset tisoč petsto sedeminšestdeset")
      expect(Num2words.to_words(9_876_543_210, :sl)).to eq(
        "devet milijard osemsto šestinsedemdeset milijonov petsto triinštirideset tisoč dvesto deset"
      )
    end
  end

  context "feminine option" do
    it "uses feminine forms" do
      expect(Num2words.to_words(1, :sl, feminine: true)).to eq("ena")
      expect(Num2words.to_words(2, :sl, feminine: true)).to eq("dve")
      expect(Num2words.to_words(21, :sl, feminine: true)).to eq("enaindvajset")
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :sl)).to eq("minus en")
      expect(Num2words.to_words(-21, :sl)).to eq("minus enaindvajset")
      expect(Num2words.to_words("-42", :sl)).to eq("minus dvainštirideset")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :sl)).to eq("tri celih pet desetin")
      expect(Num2words.to_words("3,5", :sl)).to eq("tri celih pet desetin")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :sl)).to eq("nič celih pet desetin")
      expect(Num2words.to_words(2.25, :sl)).to eq("dva celih petindvajset stotin")
      expect(Num2words.to_words(3.01, :sl)).to eq("tri celih ena stotina")
      expect(Num2words.to_words(-1.2, :sl)).to eq("minus en celih dve desetini")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :sl, joiner: :and)).to eq("nič in pet desetin")
      expect(Num2words.to_words(12.12, :sl, style: :decimal)).to eq("dvanajst vejica en dva")
      expect(Num2words.to_words("3,05", :sl, style: :decimal)).to eq("tri vejica nič pet")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :sl)).to eq("en evro nič centov")
      expect(Num2words.to_currency(2, :sl)).to eq("dva evra nič centov")
      expect(Num2words.to_currency("12.50", :sl)).to eq("dvanajst evrov petdeset centov")
      expect(Num2words.to_currency("12.50", :sl, code: :BRL)).to eq("dvanajst brazilskih realov petdeset centavov")
      expect(Num2words.to_currency(12, :sl, minor: :nonzero)).to eq("dvanajst evrov")
      expect(Num2words.to_currency(12.5, :sl, minor: :never)).to eq("dvanajst evrov")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :sl)).to eq("enaindvajsetega avgusta dva tisoč štiriindvajset")
      expect(Num2words.to_words("14:35:42", :sl)).to eq("štirinajst ur petintrideset minut dvainštirideset sekund")
      expect(Num2words.to_words("2024-08-21 14:35:42", :sl)).to eq(
        "enaindvajsetega avgusta dva tisoč štiriindvajset, štirinajst ur petintrideset minut dvainštirideset sekund"
      )
    end
  end
end
