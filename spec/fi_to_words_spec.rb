# frozen_string_literal: true

require "num2words"

RSpec.describe "Finnish locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :fi)).to eq("nolla")
      expect(Num2words.to_words(1, :fi)).to eq("yksi")
      expect(Num2words.to_words(2, :fi)).to eq("kaksi")
      expect(Num2words.to_words(5, :fi)).to eq("viisi")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :fi)).to eq("kymmenen")
      expect(Num2words.to_words(11, :fi)).to eq("yksitoista")
      expect(Num2words.to_words(19, :fi)).to eq("yhdeksäntoista")
      expect(Num2words.to_words(20, :fi)).to eq("kaksikymmentä")
      expect(Num2words.to_words(21, :fi)).to eq("kaksikymmentäyksi")
      expect(Num2words.to_words(24, :fi)).to eq("kaksikymmentäneljä")
      expect(Num2words.to_words(35, :fi)).to eq("kolmekymmentäviisi")
      expect(Num2words.to_words(99, :fi)).to eq("yhdeksänkymmentäyhdeksän")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :fi)).to eq("sata")
      expect(Num2words.to_words(101, :fi)).to eq("satayksi")
      expect(Num2words.to_words(105, :fi)).to eq("sataviisi")
      expect(Num2words.to_words(124, :fi)).to eq("satakaksikymmentäneljä")
      expect(Num2words.to_words(999, :fi)).to eq("yhdeksänsataayhdeksänkymmentäyhdeksän")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :fi)).to eq("tuhat")
      expect(Num2words.to_words(2_000, :fi)).to eq("kaksi tuhatta")
      expect(Num2words.to_words(5_000, :fi)).to eq("viisi tuhatta")
      expect(Num2words.to_words(21_000, :fi)).to eq("kaksikymmentäyksi tuhatta")
      expect(Num2words.to_words(22_000, :fi)).to eq("kaksikymmentäkaksi tuhatta")
      expect(Num2words.to_words(25_000, :fi)).to eq("kaksikymmentäviisi tuhatta")
      expect(Num2words.to_words(1_001, :fi)).to eq("tuhat yksi")
      expect(Num2words.to_words(2_002, :fi)).to eq("kaksi tuhatta kaksi")
      expect(Num2words.to_words(5_005, :fi)).to eq("viisi tuhatta viisi")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :fi)).to eq("yksi miljoona")
      expect(Num2words.to_words(2_000_000, :fi)).to eq("kaksi miljoonaa")
      expect(Num2words.to_words(5_000_000, :fi)).to eq("viisi miljoonaa")
      expect(Num2words.to_words(1_000_000_000, :fi)).to eq("yksi miljardi")
      expect(Num2words.to_words(2_000_000_000, :fi)).to eq("kaksi miljardia")
      expect(Num2words.to_words(5_000_000_000, :fi)).to eq("viisi miljardia")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :fi)).to eq("yksi miljoona kaksisataakolmekymmentäneljä tuhatta viisisataakuusikymmentäseitsemän")
      expect(Num2words.to_words(1_000_001, :fi)).to eq("yksi miljoona yksi")
      expect(Num2words.to_words(2_021_004, :fi)).to eq("kaksi miljoonaa kaksikymmentäyksi tuhatta neljä")
    end
  end

  context "feminine option" do
    it "does not change Finnish output" do
      expect(Num2words.to_words(1, :fi, feminine: true)).to eq("yksi")
      expect(Num2words.to_words(2, :fi, feminine: true)).to eq("kaksi")
      expect(Num2words.to_words(21, :fi, feminine: true)).to eq("kaksikymmentäyksi")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :fi)).to eq("miinus yksi")
      expect(Num2words.to_words(-21, :fi)).to eq("miinus kaksikymmentäyksi")
      expect(Num2words.to_words(-1_000, :fi)).to eq("miinus tuhat")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :fi)).to eq("seitsemän")
      expect(Num2words.to_words("-42", :fi)).to eq("miinus neljäkymmentäkaksi")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :fi)).to eq("kolme kokonaista viisi kymmenesosaa")
      expect(Num2words.to_words("3,5", :fi)).to eq("kolme kokonaista viisi kymmenesosaa")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :fi)).to eq("nolla kokonaista viisi kymmenesosaa")
      expect(Num2words.to_words(2.25, :fi)).to eq("kaksi kokonaista kaksikymmentäviisi sadasosaa")
      expect(Num2words.to_words(3.01, :fi)).to eq("kolme kokonaista yksi sadasosa")
      expect(Num2words.to_words(-1.2, :fi)).to eq("miinus yksi kokonaista kaksi kymmenesosaa")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :fi, joiner: :and)).to eq("nolla ja viisi kymmenesosaa")
      expect(Num2words.to_words(12.12, :fi, style: :decimal)).to eq("kaksitoista pilkku yksi kaksi")
      expect(Num2words.to_words("3,05", :fi, style: :decimal)).to eq("kolme pilkku nolla viisi")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :fi)).to eq(
        "yhdeksän miljardia kahdeksansataaseitsemänkymmentäkuusi miljoonaa viisisataaneljäkymmentäkolme tuhatta kaksisataakymmenen"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :fi)).to eq("yksitoista tuhatta yksitoista")
      expect(Num2words.to_words(1_011_011, :fi)).to eq("yksi miljoona yksitoista tuhatta yksitoista")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "kaksikymmentäyksi"
      expect(Num2words.to_words(21, :fi, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :fi, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :fi, word_case: :capitalize)).to eq("Kaksikymmentäyksi")
      expect(Num2words.to_words(21, :fi, word_case: :title)).to eq("Kaksikymmentäyksi")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :fi)).to eq("yksi euro nolla senttiä")
      expect(Num2words.to_currency(2, :fi)).to eq("kaksi euroa nolla senttiä")
      expect(Num2words.to_currency("12.50", :fi)).to eq("kaksitoista euroa viisikymmentä senttiä")
      expect(Num2words.to_currency("12.50", :fi, code: :BRL)).to eq("kaksitoista brasilian realia viisikymmentä sentavoa")
      expect(Num2words.to_currency(12, :fi, minor: :nonzero)).to eq("kaksitoista euroa")
      expect(Num2words.to_currency(12.5, :fi, minor: :never)).to eq("kaksitoista euroa")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :fi)).to eq("kahdennenkymmenennen ensimmäisen elokuuta kaksi tuhatta kaksikymmentäneljä")
      expect(Num2words.to_words("14:35:42", :fi)).to eq("neljätoista tuntia kolmekymmentäviisi minuuttia neljäkymmentäkaksi sekuntia")
      expect(Num2words.to_words("2024-08-21 14:35:42", :fi)).to eq(
        "kahdennenkymmenennen ensimmäisen elokuuta kaksi tuhatta kaksikymmentäneljä, neljätoista tuntia kolmekymmentäviisi minuuttia neljäkymmentäkaksi sekuntia"
      )
    end
  end
end
