# frozen_string_literal: true

require "num2words"

RSpec.describe "Dutch locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :nl)).to eq("nul")
      expect(Num2words.to_words(1, :nl)).to eq("één")
      expect(Num2words.to_words(2, :nl)).to eq("twee")
      expect(Num2words.to_words(5, :nl)).to eq("vijf")
    end

    it "converts Dutch-specific tens and teens" do
      expect(Num2words.to_words(10, :nl)).to eq("tien")
      expect(Num2words.to_words(11, :nl)).to eq("elf")
      expect(Num2words.to_words(19, :nl)).to eq("negentien")
      expect(Num2words.to_words(20, :nl)).to eq("twintig")
      expect(Num2words.to_words(21, :nl)).to eq("éénentwintig")
      expect(Num2words.to_words(24, :nl)).to eq("vierentwintig")
      expect(Num2words.to_words(35, :nl)).to eq("vijfendertig")
      expect(Num2words.to_words(99, :nl)).to eq("negenennegentig")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :nl)).to eq("honderd")
      expect(Num2words.to_words(101, :nl)).to eq("honderd één")
      expect(Num2words.to_words(105, :nl)).to eq("honderd vijf")
      expect(Num2words.to_words(124, :nl)).to eq("honderd vierentwintig")
      expect(Num2words.to_words(999, :nl)).to eq("negenhonderd negenennegentig")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :nl)).to eq("duizend")
      expect(Num2words.to_words(2_000, :nl)).to eq("twee duizend")
      expect(Num2words.to_words(5_000, :nl)).to eq("vijf duizend")
      expect(Num2words.to_words(21_000, :nl)).to eq("éénentwintig duizend")
      expect(Num2words.to_words(1_001, :nl)).to eq("duizend één")
      expect(Num2words.to_words(2_002, :nl)).to eq("twee duizend twee")
      expect(Num2words.to_words(5_005, :nl)).to eq("vijf duizend vijf")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :nl)).to eq("één miljoen")
      expect(Num2words.to_words(2_000_000, :nl)).to eq("twee miljoen")
      expect(Num2words.to_words(1_234_567, :nl)).to eq(
        "één miljoen tweehonderd vierendertig duizend vijfhonderd zevenenzestig"
      )
      expect(Num2words.to_words(9_876_543_210, :nl)).to eq(
        "negen miljard achthonderd zesenzeventig miljoen vijfhonderd drieënveertig duizend tweehonderd tien"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :nl)).to eq("min één")
      expect(Num2words.to_words(-21, :nl)).to eq("min éénentwintig")
      expect(Num2words.to_words("-42", :nl)).to eq("min tweeënveertig")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :nl)).to eq("drie komma vijf tienden")
      expect(Num2words.to_words("3,5", :nl)).to eq("drie komma vijf tienden")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :nl)).to eq("nul komma vijf tienden")
      expect(Num2words.to_words(2.25, :nl)).to eq("twee komma vijfentwintig honderdsten")
      expect(Num2words.to_words(3.01, :nl)).to eq("drie komma één honderdste")
      expect(Num2words.to_words(-1.2, :nl)).to eq("min één komma twee tienden")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :nl, joiner: :and)).to eq("nul en vijf tienden")
      expect(Num2words.to_words(12.12, :nl, style: :decimal)).to eq("twaalf komma één twee")
      expect(Num2words.to_words("3,05", :nl, style: :decimal)).to eq("drie komma nul vijf")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :nl)).to eq("één euro nul cent")
      expect(Num2words.to_currency(2, :nl)).to eq("twee euro nul cent")
      expect(Num2words.to_currency("12.50", :nl)).to eq("twaalf euro vijftig cent")
      expect(Num2words.to_currency("12.50", :nl, code: :BRL)).to eq("twaalf braziliaanse real vijftig centavo")
      expect(Num2words.to_currency(12, :nl, minor: :nonzero)).to eq("twaalf euro")
      expect(Num2words.to_currency(12.5, :nl, minor: :never)).to eq("twaalf euro")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :nl)).to eq("eenentwintigste augustus twee duizend vierentwintig")
      expect(Num2words.to_words("14:35:42", :nl)).to eq("veertien uur vijfendertig minuten tweeënveertig seconden")
      expect(Num2words.to_words("2024-08-21 14:35:42", :nl)).to eq(
        "eenentwintigste augustus twee duizend vierentwintig, veertien uur vijfendertig minuten tweeënveertig seconden"
      )
    end
  end
end
