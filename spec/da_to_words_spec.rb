# frozen_string_literal: true

require "num2words"

RSpec.describe "Danish locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :da)).to eq("nul")
      expect(Num2words.to_words(1, :da)).to eq("en")
      expect(Num2words.to_words(2, :da)).to eq("to")
      expect(Num2words.to_words(5, :da)).to eq("fem")
    end

    it "converts Danish-specific tens and teens" do
      expect(Num2words.to_words(10, :da)).to eq("ti")
      expect(Num2words.to_words(11, :da)).to eq("elleve")
      expect(Num2words.to_words(19, :da)).to eq("nitten")
      expect(Num2words.to_words(20, :da)).to eq("tyve")
      expect(Num2words.to_words(21, :da)).to eq("enogtyve")
      expect(Num2words.to_words(24, :da)).to eq("fireogtyve")
      expect(Num2words.to_words(35, :da)).to eq("femogtredive")
      expect(Num2words.to_words(99, :da)).to eq("nioghalvfems")
    end

    it "converts hundreds with Danish conjunction" do
      expect(Num2words.to_words(100, :da)).to eq("hundrede")
      expect(Num2words.to_words(101, :da)).to eq("hundrede og en")
      expect(Num2words.to_words(105, :da)).to eq("hundrede og fem")
      expect(Num2words.to_words(124, :da)).to eq("hundrede og fireogtyve")
      expect(Num2words.to_words(999, :da)).to eq("ni hundrede og nioghalvfems")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :da)).to eq("et tusind")
      expect(Num2words.to_words(2_000, :da)).to eq("to tusind")
      expect(Num2words.to_words(5_000, :da)).to eq("fem tusind")
      expect(Num2words.to_words(21_000, :da)).to eq("enogtyve tusind")
      expect(Num2words.to_words(1_001, :da)).to eq("et tusind og en")
      expect(Num2words.to_words(2_002, :da)).to eq("to tusind og to")
      expect(Num2words.to_words(5_005, :da)).to eq("fem tusind og fem")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :da)).to eq("en million")
      expect(Num2words.to_words(2_000_000, :da)).to eq("to millioner")
      expect(Num2words.to_words(1_234_567, :da)).to eq(
        "en million to hundrede og fireogtredive tusind fem hundrede og syvogtres"
      )
      expect(Num2words.to_words(9_876_543_210, :da)).to eq(
        "ni milliarder otte hundrede og seksoghalvfjerds millioner fem hundrede og treogfyrre tusind to hundrede og ti"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :da)).to eq("minus en")
      expect(Num2words.to_words(-21, :da)).to eq("minus enogtyve")
      expect(Num2words.to_words("-42", :da)).to eq("minus toogfyrre")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :da)).to eq("tre komma fem tiendedele")
      expect(Num2words.to_words("3,5", :da)).to eq("tre komma fem tiendedele")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :da)).to eq("nul komma fem tiendedele")
      expect(Num2words.to_words(2.25, :da)).to eq("to komma femogtyve hundrededele")
      expect(Num2words.to_words(3.01, :da)).to eq("tre komma en hundrededel")
      expect(Num2words.to_words(-1.2, :da)).to eq("minus en komma to tiendedele")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :da, joiner: :and)).to eq("nul og fem tiendedele")
      expect(Num2words.to_words(2.25, :da, joiner: :and)).to eq("to og femogtyve hundrededele")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :da)).to eq("en krone nul ører")
      expect(Num2words.to_currency(2, :da)).to eq("to kroner nul ører")
      expect(Num2words.to_currency("12.50", :da)).to eq("tolv kroner halvtreds ører")
      expect(Num2words.to_currency("12.50", :da, code: :BRL)).to eq("tolv brasilianske real halvtreds centavo")
      expect(Num2words.to_currency(12, :da, minor: :nonzero)).to eq("tolv kroner")
      expect(Num2words.to_currency(12.5, :da, minor: :never)).to eq("tolv kroner")
    end

    it "has a complete unique currency list" do
      currencies = Num2words.available_currencies(:da)

      expect(currencies.uniq).to eq(currencies)
      expect(currencies.size).to eq(32)
      expect(currencies).to include(:BRL)
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :da)).to eq("enogtyvende. august to tusind og fireogtyve")
      expect(Num2words.to_words("14:35:42", :da)).to eq("fjorten timer femogtredive minutter toogfyrre sekunder")
      expect(Num2words.to_words("2024-08-21 14:35:42", :da)).to eq(
        "enogtyvende. august to tusind og fireogtyve, fjorten timer femogtredive minutter toogfyrre sekunder"
      )
    end
  end
end
