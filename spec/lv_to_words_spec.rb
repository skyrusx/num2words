# frozen_string_literal: true

require "num2words"

RSpec.describe "Latvian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :lv)).to eq("nulle")
      expect(Num2words.to_words(1, :lv)).to eq("viens")
      expect(Num2words.to_words(2, :lv)).to eq("divi")
      expect(Num2words.to_words(5, :lv)).to eq("pieci")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :lv)).to eq("desmit")
      expect(Num2words.to_words(11, :lv)).to eq("vienpadsmit")
      expect(Num2words.to_words(19, :lv)).to eq("deviņpadsmit")
      expect(Num2words.to_words(20, :lv)).to eq("divdesmit")
      expect(Num2words.to_words(21, :lv)).to eq("divdesmit viens")
      expect(Num2words.to_words(24, :lv)).to eq("divdesmit četri")
      expect(Num2words.to_words(35, :lv)).to eq("trīsdesmit pieci")
      expect(Num2words.to_words(99, :lv)).to eq("deviņdesmit deviņi")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :lv)).to eq("simts")
      expect(Num2words.to_words(101, :lv)).to eq("simts viens")
      expect(Num2words.to_words(105, :lv)).to eq("simts pieci")
      expect(Num2words.to_words(124, :lv)).to eq("simts divdesmit četri")
      expect(Num2words.to_words(999, :lv)).to eq("deviņi simti deviņdesmit deviņi")
    end
  end

  context "thousands and large scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :lv)).to eq("viens tūkstotis")
      expect(Num2words.to_words(2_000, :lv)).to eq("divi tūkstoši")
      expect(Num2words.to_words(5_000, :lv)).to eq("pieci tūkstoši")
      expect(Num2words.to_words(21_000, :lv)).to eq("divdesmit viens tūkstotis")
      expect(Num2words.to_words(22_000, :lv)).to eq("divdesmit divi tūkstoši")
      expect(Num2words.to_words(25_000, :lv)).to eq("divdesmit pieci tūkstoši")
      expect(Num2words.to_words(11_000, :lv)).to eq("vienpadsmit tūkstoši")
      expect(Num2words.to_words(1_001, :lv)).to eq("viens tūkstotis viens")
      expect(Num2words.to_words(2_002, :lv)).to eq("divi tūkstoši divi")
      expect(Num2words.to_words(5_005, :lv)).to eq("pieci tūkstoši pieci")
    end

    it "converts million and billion values" do
      expect(Num2words.to_words(1_000_000, :lv)).to eq("viens miljons")
      expect(Num2words.to_words(2_000_000, :lv)).to eq("divi miljoni")
      expect(Num2words.to_words(5_000_000, :lv)).to eq("pieci miljoni")
      expect(Num2words.to_words(11_000_000, :lv)).to eq("vienpadsmit miljoni")
      expect(Num2words.to_words(1_000_000_000, :lv)).to eq("viens miljards")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :lv)).to eq("viens miljons divi simti trīsdesmit četri tūkstoši pieci simti sešdesmit septiņi")
      expect(Num2words.to_words(1_000_001, :lv)).to eq("viens miljons viens")
      expect(Num2words.to_words(2_021_004, :lv)).to eq("divi miljoni divdesmit viens tūkstotis četri")
    end
  end

  context "feminine option" do
    it "changes Latvian one and two forms" do
      expect(Num2words.to_words(1, :lv, feminine: true)).to eq("viena")
      expect(Num2words.to_words(2, :lv, feminine: true)).to eq("divas")
      expect(Num2words.to_words(21, :lv, feminine: true)).to eq("divdesmit viena")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :lv)).to eq("mīnus viens")
      expect(Num2words.to_words(-21, :lv)).to eq("mīnus divdesmit viens")
      expect(Num2words.to_words(-1_000, :lv)).to eq("mīnus viens tūkstotis")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :lv)).to eq("septiņi")
      expect(Num2words.to_words("-42", :lv)).to eq("mīnus četrdesmit divi")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :lv)).to eq("trīs veseli piecas desmitdaļas")
      expect(Num2words.to_words("3,5", :lv)).to eq("trīs veseli piecas desmitdaļas")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :lv)).to eq("nulle veseli piecas desmitdaļas")
      expect(Num2words.to_words(2.25, :lv)).to eq("divi veseli divdesmit piecas simtdaļas")
      expect(Num2words.to_words(3.01, :lv)).to eq("trīs veseli viena simtdaļa")
      expect(Num2words.to_words(-1.2, :lv)).to eq("mīnus viens veseli divas desmitdaļas")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :lv, joiner: :and)).to eq("nulle un piecas desmitdaļas")
      expect(Num2words.to_words(12.12, :lv, style: :decimal)).to eq("divpadsmit komats viens divi")
      expect(Num2words.to_words("3,05", :lv, style: :decimal)).to eq("trīs komats nulle pieci")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :lv)).to eq(
        "deviņi miljardi astoņi simti septiņdesmit seši miljoni pieci simti četrdesmit trīs tūkstoši divi simti desmit"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :lv)).to eq("vienpadsmit tūkstoši vienpadsmit")
      expect(Num2words.to_words(1_011_011, :lv)).to eq("viens miljons vienpadsmit tūkstoši vienpadsmit")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "divdesmit viens"
      expect(Num2words.to_words(21, :lv, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :lv, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :lv, word_case: :capitalize)).to eq("Divdesmit viens")
      expect(Num2words.to_words(21, :lv, word_case: :title)).to eq("Divdesmit Viens")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :lv)).to eq("viens eiro nulle centu")
      expect(Num2words.to_currency(2, :lv)).to eq("divi eiro nulle centu")
      expect(Num2words.to_currency("12.50", :lv)).to eq("divpadsmit eiro piecdesmit centu")
      expect(Num2words.to_currency("12.50", :lv, code: :BRL)).to eq("divpadsmit brazīlijas reālu piecdesmit sentavo")
      expect(Num2words.to_currency(12, :lv, minor: :nonzero)).to eq("divpadsmit eiro")
      expect(Num2words.to_currency(12.5, :lv, minor: :never)).to eq("divpadsmit eiro")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :lv)).to eq("divdesmit pirmā augusts divi tūkstoši divdesmit četri")
      expect(Num2words.to_words("14:35:42", :lv)).to eq("četrpadsmit stundu trīsdesmit piecas minūtes četrdesmit divas sekundes")
      expect(Num2words.to_words("2024-08-21 14:35:42", :lv)).to eq(
        "divdesmit pirmā augusts divi tūkstoši divdesmit četri, četrpadsmit stundu trīsdesmit piecas minūtes četrdesmit divas sekundes"
      )
    end
  end
end
