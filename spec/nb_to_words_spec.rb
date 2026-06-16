# frozen_string_literal: true

require "num2words"

RSpec.describe "Norwegian Bokmal locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :nb)).to eq("null")
      expect(Num2words.to_words(1, :nb)).to eq("en")
      expect(Num2words.to_words(2, :nb)).to eq("to")
      expect(Num2words.to_words(5, :nb)).to eq("fem")
    end

    it "converts Norwegian tens and teens" do
      expect(Num2words.to_words(10, :nb)).to eq("ti")
      expect(Num2words.to_words(11, :nb)).to eq("elleve")
      expect(Num2words.to_words(19, :nb)).to eq("nitten")
      expect(Num2words.to_words(20, :nb)).to eq("tjue")
      expect(Num2words.to_words(21, :nb)).to eq("tjueen")
      expect(Num2words.to_words(24, :nb)).to eq("tjuefire")
      expect(Num2words.to_words(35, :nb)).to eq("trettifem")
      expect(Num2words.to_words(99, :nb)).to eq("nittini")
    end

    it "converts hundreds with conjunction" do
      expect(Num2words.to_words(100, :nb)).to eq("hundre")
      expect(Num2words.to_words(101, :nb)).to eq("hundre og en")
      expect(Num2words.to_words(105, :nb)).to eq("hundre og fem")
      expect(Num2words.to_words(124, :nb)).to eq("hundre og tjuefire")
      expect(Num2words.to_words(999, :nb)).to eq("ni hundre og nittini")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :nb)).to eq("ett tusen")
      expect(Num2words.to_words(2_000, :nb)).to eq("to tusen")
      expect(Num2words.to_words(5_000, :nb)).to eq("fem tusen")
      expect(Num2words.to_words(21_000, :nb)).to eq("tjueen tusen")
      expect(Num2words.to_words(1_001, :nb)).to eq("ett tusen og en")
      expect(Num2words.to_words(2_002, :nb)).to eq("to tusen og to")
      expect(Num2words.to_words(5_005, :nb)).to eq("fem tusen og fem")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :nb)).to eq("en million")
      expect(Num2words.to_words(2_000_000, :nb)).to eq("to millioner")
      expect(Num2words.to_words(1_234_567, :nb)).to eq(
        "en million to hundre og trettifire tusen fem hundre og sekstisju"
      )
      expect(Num2words.to_words(9_876_543_210, :nb)).to eq(
        "ni milliarder åtte hundre og syttiseks millioner fem hundre og førtitre tusen to hundre og ti"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :nb)).to eq("minus en")
      expect(Num2words.to_words(-21, :nb)).to eq("minus tjueen")
      expect(Num2words.to_words("-42", :nb)).to eq("minus førtito")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :nb)).to eq("tre komma fem tideler")
      expect(Num2words.to_words("3,5", :nb)).to eq("tre komma fem tideler")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :nb)).to eq("null komma fem tideler")
      expect(Num2words.to_words(2.25, :nb)).to eq("to komma tjuefem hundredeler")
      expect(Num2words.to_words(3.01, :nb)).to eq("tre komma en hundredel")
      expect(Num2words.to_words(-1.2, :nb)).to eq("minus en komma to tideler")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :nb, joiner: :and)).to eq("null og fem tideler")
      expect(Num2words.to_words(12.12, :nb, style: :decimal)).to eq("tolv komma en to")
      expect(Num2words.to_words("3,05", :nb, style: :decimal)).to eq("tre komma null fem")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :nb)).to eq("en krone null øre")
      expect(Num2words.to_currency(2, :nb)).to eq("to kroner null øre")
      expect(Num2words.to_currency("12.50", :nb)).to eq("tolv kroner femti øre")
      expect(Num2words.to_currency("12.50", :nb, code: :BRL)).to eq("tolv brasilianske real femti centavo")
      expect(Num2words.to_currency(12, :nb, minor: :nonzero)).to eq("tolv kroner")
      expect(Num2words.to_currency(12.5, :nb, minor: :never)).to eq("tolv kroner")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :nb)).to eq("tjueførste. august to tusen og tjuefire")
      expect(Num2words.to_words("14:35:42", :nb)).to eq("fjorten timer trettifem minutter førtito sekunder")
      expect(Num2words.to_words("2024-08-21 14:35:42", :nb)).to eq(
        "tjueførste. august to tusen og tjuefire, fjorten timer trettifem minutter førtito sekunder"
      )
    end
  end
end
