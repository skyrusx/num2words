# frozen_string_literal: true

require "num2words"

RSpec.describe "Croatian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :hr)).to eq("nula")
      expect(Num2words.to_words(1, :hr)).to eq("jedan")
      expect(Num2words.to_words(2, :hr)).to eq("dva")
      expect(Num2words.to_words(5, :hr)).to eq("pet")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :hr)).to eq("deset")
      expect(Num2words.to_words(11, :hr)).to eq("jedanaest")
      expect(Num2words.to_words(19, :hr)).to eq("devetnaest")
      expect(Num2words.to_words(20, :hr)).to eq("dvadeset")
      expect(Num2words.to_words(21, :hr)).to eq("dvadeset jedan")
      expect(Num2words.to_words(24, :hr)).to eq("dvadeset četiri")
      expect(Num2words.to_words(35, :hr)).to eq("trideset pet")
      expect(Num2words.to_words(99, :hr)).to eq("devedeset devet")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :hr)).to eq("sto")
      expect(Num2words.to_words(101, :hr)).to eq("sto jedan")
      expect(Num2words.to_words(105, :hr)).to eq("sto pet")
      expect(Num2words.to_words(124, :hr)).to eq("sto dvadeset četiri")
      expect(Num2words.to_words(999, :hr)).to eq("devetsto devedeset devet")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :hr)).to eq("jedna tisuća")
      expect(Num2words.to_words(2_000, :hr)).to eq("dvije tisuće")
      expect(Num2words.to_words(5_000, :hr)).to eq("pet tisuća")
      expect(Num2words.to_words(21_000, :hr)).to eq("dvadeset jedna tisuća")
      expect(Num2words.to_words(22_000, :hr)).to eq("dvadeset dvije tisuće")
      expect(Num2words.to_words(25_000, :hr)).to eq("dvadeset pet tisuća")
      expect(Num2words.to_words(1_001, :hr)).to eq("jedna tisuća jedan")
      expect(Num2words.to_words(2_002, :hr)).to eq("dvije tisuće dva")
      expect(Num2words.to_words(5_005, :hr)).to eq("pet tisuća pet")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :hr)).to eq("jedan milijun")
      expect(Num2words.to_words(2_000_000, :hr)).to eq("dva milijuna")
      expect(Num2words.to_words(5_000_000, :hr)).to eq("pet milijuna")
      expect(Num2words.to_words(1_000_000_000, :hr)).to eq("jedna milijarda")
      expect(Num2words.to_words(2_000_000_000, :hr)).to eq("dvije milijarde")
      expect(Num2words.to_words(5_000_000_000, :hr)).to eq("pet milijardi")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :hr)).to eq("jedan milijun dvjesto trideset četiri tisuće petsto šezdeset sedam")
      expect(Num2words.to_words(1_000_001, :hr)).to eq("jedan milijun jedan")
      expect(Num2words.to_words(2_021_004, :hr)).to eq("dva milijuna dvadeset jedna tisuća četiri")
    end
  end

  context "feminine option" do
    it "uses feminine forms" do
      expect(Num2words.to_words(1, :hr, feminine: true)).to eq("jedna")
      expect(Num2words.to_words(2, :hr, feminine: true)).to eq("dvije")
      expect(Num2words.to_words(21, :hr, feminine: true)).to eq("dvadeset jedna")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :hr)).to eq("minus jedan")
      expect(Num2words.to_words(-21, :hr)).to eq("minus dvadeset jedan")
      expect(Num2words.to_words(-1_000, :hr)).to eq("minus jedna tisuća")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :hr)).to eq("sedam")
      expect(Num2words.to_words("-42", :hr)).to eq("minus četrdeset dva")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :hr)).to eq("tri i pet desetina")
      expect(Num2words.to_words("3,5", :hr)).to eq("tri i pet desetina")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :hr)).to eq("nula i pet desetina")
      expect(Num2words.to_words(2.25, :hr)).to eq("dva i dvadeset pet stotina")
      expect(Num2words.to_words(3.01, :hr)).to eq("tri i jedna stotina")
      expect(Num2words.to_words(-1.2, :hr)).to eq("minus jedan i dvije desetine")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :hr, style: :decimal)).to eq("dvanaest zarez jedan dva")
      expect(Num2words.to_words("3,05", :hr, style: :decimal)).to eq("tri zarez nula pet")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :hr)).to eq(
        "devet milijardi osamsto sedamdeset šest milijuna petsto četrdeset tri tisuće dvjesto deset"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :hr)).to eq("jedanaest tisuća jedanaest")
      expect(Num2words.to_words(1_011_011, :hr)).to eq("jedan milijun jedanaest tisuća jedanaest")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "dvadeset jedan"
      expect(Num2words.to_words(21, :hr, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :hr, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :hr, word_case: :capitalize)).to eq("Dvadeset jedan")
      expect(Num2words.to_words(21, :hr, word_case: :title)).to eq("Dvadeset Jedan")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :hr)).to eq("jedan euro nula centi")
      expect(Num2words.to_currency(2, :hr)).to eq("dva eura nula centi")
      expect(Num2words.to_currency("12.50", :hr)).to eq("dvanaest eura pedeset centi")
      expect(Num2words.to_currency("12.50", :hr, code: :BRL)).to eq("dvanaest brazilskih reala pedeset centava")
      expect(Num2words.to_currency(12, :hr, minor: :nonzero)).to eq("dvanaest eura")
      expect(Num2words.to_currency(12.5, :hr, minor: :never)).to eq("dvanaest eura")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :hr)).to eq("dvadeset prvog kolovoza dvije tisuće dvadeset četiri")
      expect(Num2words.to_words("14:35:42", :hr)).to eq("četrnaest sati trideset pet minuta četrdeset dvije sekunde")
      expect(Num2words.to_words("2024-08-21 14:35:42", :hr)).to eq(
        "dvadeset prvog kolovoza dvije tisuće dvadeset četiri, četrnaest sati trideset pet minuta četrdeset dvije sekunde"
      )
    end
  end
end
