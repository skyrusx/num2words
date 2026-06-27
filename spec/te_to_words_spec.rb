# frozen_string_literal: true

require "num2words"

RSpec.describe "Telugu locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :te)).to eq("సున్నా")
      expect(Num2words.to_words(1, :te)).to eq("ఒకటి")
      expect(Num2words.to_words(2, :te)).to eq("రెండు")
      expect(Num2words.to_words(5, :te)).to eq("ఐదు")
    end

    it "converts Telugu-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :te)).to eq("పది")
      expect(Num2words.to_words(11, :te)).to eq("పదకొండు")
      expect(Num2words.to_words(19, :te)).to eq("పంతొమ్మిది")
      expect(Num2words.to_words(20, :te)).to eq("ఇరవై")
      expect(Num2words.to_words(21, :te)).to eq("ఇరవై ఒకటి")
      expect(Num2words.to_words(24, :te)).to eq("ఇరవై నాలుగు")
      expect(Num2words.to_words(35, :te)).to eq("ముప్పై ఐదు")
      expect(Num2words.to_words(99, :te)).to eq("తొంభై తొమ్మిది")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :te)).to eq("వంద")
      expect(Num2words.to_words(101, :te)).to eq("వంద ఒకటి")
      expect(Num2words.to_words(105, :te)).to eq("వంద ఐదు")
      expect(Num2words.to_words(124, :te)).to eq("వంద ఇరవై నాలుగు")
      expect(Num2words.to_words(999, :te)).to eq("తొమ్మిది వందలు తొంభై తొమ్మిది")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :te)).to eq("ఒకటి వెయ్యి")
      expect(Num2words.to_words(2_000, :te)).to eq("రెండు వెయ్యి")
      expect(Num2words.to_words(5_000, :te)).to eq("ఐదు వెయ్యి")
      expect(Num2words.to_words(21_000, :te)).to eq("ఇరవై ఒకటి వెయ్యి")
      expect(Num2words.to_words(1_001, :te)).to eq("ఒకటి వెయ్యి ఒకటి")
      expect(Num2words.to_words(2_002, :te)).to eq("రెండు వెయ్యి రెండు")
    end

    it "converts lakh, crore and large values" do
      expect(Num2words.to_words(100_000, :te)).to eq("ఒకటి లక్ష")
      expect(Num2words.to_words(2_000_000, :te)).to eq("ఇరవై లక్ష")
      expect(Num2words.to_words(10_000_000, :te)).to eq("ఒకటి కోటి")
      expect(Num2words.to_words(1_000_000_000, :te)).to eq("ఒకటి వంద కోట్లు")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :te)).to eq("పన్నెండు లక్ష ముప్పై నాలుగు వెయ్యి ఐదు వందలు అరవై ఏడు")
      expect(Num2words.to_words(9_876_543_210, :te)).to eq(
        "తొమ్మిది వంద కోట్లు ఎనభై ఏడు కోటి అరవై ఐదు లక్ష నలభై మూడు వెయ్యి రెండు వందలు పది"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :te)).to eq("మైనస్ ఒకటి")
      expect(Num2words.to_words(-21, :te)).to eq("మైనస్ ఇరవై ఒకటి")
      expect(Num2words.to_words("-42", :te)).to eq("మైనస్ నలభై రెండు")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :te)).to eq("మూడు పూర్తి ఐదు పదవ వంతు")
      expect(Num2words.to_words("3,5", :te)).to eq("మూడు పూర్తి ఐదు పదవ వంతు")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :te)).to eq("సున్నా పూర్తి ఐదు పదవ వంతు")
      expect(Num2words.to_words(2.25, :te)).to eq("రెండు పూర్తి ఇరవై ఐదు వందవ వంతు")
      expect(Num2words.to_words(3.01, :te)).to eq("మూడు పూర్తి ఒకటి వందవ వంతు")
      expect(Num2words.to_words(-1.2, :te)).to eq("మైనస్ ఒకటి పూర్తి రెండు పదవ వంతు")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :te, joiner: :and)).to eq("సున్నా మరియు ఐదు పదవ వంతు")
      expect(Num2words.to_words(12.12, :te, style: :decimal)).to eq("పన్నెండు దశాంశం ఒకటి రెండు")
      expect(Num2words.to_words("3,05", :te, style: :decimal)).to eq("మూడు దశాంశం సున్నా ఐదు")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :te)).to eq("ఒకటి రూపాయి సున్నా పైసలు")
      expect(Num2words.to_currency(2, :te)).to eq("రెండు రూపాయలు సున్నా పైసలు")
      expect(Num2words.to_currency("12.50", :te)).to eq("పన్నెండు రూపాయలు యాభై పైసలు")
      expect(Num2words.to_currency("12.50", :te, code: :BRL)).to eq("పన్నెండు బ్రెజిలియన్ రియల్ యాభై సెంటావో")
      expect(Num2words.to_currency(12, :te, minor: :nonzero)).to eq("పన్నెండు రూపాయలు")
      expect(Num2words.to_currency(12.5, :te, minor: :never)).to eq("పన్నెండు రూపాయలు")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :te)).to eq("ఇరవై ఒకటవ ఆగస్టు రెండు వెయ్యి ఇరవై నాలుగు")
      expect(Num2words.to_words("14:35:42", :te)).to eq("పద్నాలుగు గంటలు ముప్పై ఐదు నిమిషాలు నలభై రెండు సెకన్లు")
      expect(Num2words.to_words("2024-08-21 14:35:42", :te)).to eq(
        "ఇరవై ఒకటవ ఆగస్టు రెండు వెయ్యి ఇరవై నాలుగు, పద్నాలుగు గంటలు ముప్పై ఐదు నిమిషాలు నలభై రెండు సెకన్లు"
      )
    end
  end
end
