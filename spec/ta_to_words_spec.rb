# frozen_string_literal: true

require "num2words"

RSpec.describe "Tamil locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ta)).to eq("பூஜ்ஜியம்")
      expect(Num2words.to_words(1, :ta)).to eq("ஒன்று")
      expect(Num2words.to_words(2, :ta)).to eq("இரண்டு")
      expect(Num2words.to_words(5, :ta)).to eq("ஐந்து")
    end

    it "converts Tamil-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :ta)).to eq("பத்து")
      expect(Num2words.to_words(11, :ta)).to eq("பதினொன்று")
      expect(Num2words.to_words(19, :ta)).to eq("பத்தொன்பது")
      expect(Num2words.to_words(20, :ta)).to eq("இருபது")
      expect(Num2words.to_words(21, :ta)).to eq("இருபத்தொன்று")
      expect(Num2words.to_words(24, :ta)).to eq("இருபத்துநான்கு")
      expect(Num2words.to_words(35, :ta)).to eq("முப்பத்தைந்து")
      expect(Num2words.to_words(99, :ta)).to eq("தொண்ணூற்றொன்பது")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :ta)).to eq("நூறு")
      expect(Num2words.to_words(101, :ta)).to eq("நூறு ஒன்று")
      expect(Num2words.to_words(105, :ta)).to eq("நூறு ஐந்து")
      expect(Num2words.to_words(124, :ta)).to eq("நூறு இருபத்துநான்கு")
      expect(Num2words.to_words(999, :ta)).to eq("தொள்ளாயிரம் தொண்ணூற்றொன்பது")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :ta)).to eq("ஒன்று ஆயிரம்")
      expect(Num2words.to_words(2_000, :ta)).to eq("இரண்டு ஆயிரம்")
      expect(Num2words.to_words(5_000, :ta)).to eq("ஐந்து ஆயிரம்")
      expect(Num2words.to_words(21_000, :ta)).to eq("இருபத்தொன்று ஆயிரம்")
      expect(Num2words.to_words(1_001, :ta)).to eq("ஒன்று ஆயிரம் ஒன்று")
      expect(Num2words.to_words(2_002, :ta)).to eq("இரண்டு ஆயிரம் இரண்டு")
    end

    it "converts lakh, crore and large values" do
      expect(Num2words.to_words(100_000, :ta)).to eq("ஒன்று லட்சம்")
      expect(Num2words.to_words(2_000_000, :ta)).to eq("இருபது லட்சம்")
      expect(Num2words.to_words(10_000_000, :ta)).to eq("ஒன்று கோடி")
      expect(Num2words.to_words(1_000_000_000, :ta)).to eq("ஒன்று நூறு கோடி")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :ta)).to eq("பன்னிரண்டு லட்சம் முப்பத்துநான்கு ஆயிரம் ஐநூறு அறுபத்தேழு")
      expect(Num2words.to_words(9_876_543_210, :ta)).to eq(
        "ஒன்பது நூறு கோடி எண்பத்தேழு கோடி அறுபத்தைந்து லட்சம் நாற்பத்துமூன்று ஆயிரம் இருநூறு பத்து"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ta)).to eq("மைனஸ் ஒன்று")
      expect(Num2words.to_words(-21, :ta)).to eq("மைனஸ் இருபத்தொன்று")
      expect(Num2words.to_words("-42", :ta)).to eq("மைனஸ் நாற்பத்திரண்டு")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :ta)).to eq("மூன்று முழு ஐந்து பத்தில் ஒன்று")
      expect(Num2words.to_words("3,5", :ta)).to eq("மூன்று முழு ஐந்து பத்தில் ஒன்று")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ta)).to eq("பூஜ்ஜியம் முழு ஐந்து பத்தில் ஒன்று")
      expect(Num2words.to_words(2.25, :ta)).to eq("இரண்டு முழு இருபத்தைந்து நூற்றில் ஒன்று")
      expect(Num2words.to_words(3.01, :ta)).to eq("மூன்று முழு ஒன்று நூற்றில் ஒன்று")
      expect(Num2words.to_words(-1.2, :ta)).to eq("மைனஸ் ஒன்று முழு இரண்டு பத்தில் ஒன்று")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :ta, joiner: :and)).to eq("பூஜ்ஜியம் மற்றும் ஐந்து பத்தில் ஒன்று")
      expect(Num2words.to_words(12.12, :ta, style: :decimal)).to eq("பன்னிரண்டு தசமம் ஒன்று இரண்டு")
      expect(Num2words.to_words("3,05", :ta, style: :decimal)).to eq("மூன்று தசமம் பூஜ்ஜியம் ஐந்து")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ta)).to eq("ஒன்று ரூபாய் பூஜ்ஜியம் பைசா")
      expect(Num2words.to_currency(2, :ta)).to eq("இரண்டு ரூபாய் பூஜ்ஜியம் பைசா")
      expect(Num2words.to_currency("12.50", :ta)).to eq("பன்னிரண்டு ரூபாய் ஐம்பது பைசா")
      expect(Num2words.to_currency("12.50", :ta, code: :BRL)).to eq("பன்னிரண்டு பிரேசிலிய ரியால் ஐம்பது சென்டாவோ")
      expect(Num2words.to_currency(12, :ta, minor: :nonzero)).to eq("பன்னிரண்டு ரூபாய்")
      expect(Num2words.to_currency(12.5, :ta, minor: :never)).to eq("பன்னிரண்டு ரூபாய்")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ta)).to eq("இருபத்தொன்றாம் ஆகஸ்ட் இரண்டு ஆயிரம் இருபத்துநான்கு")
      expect(Num2words.to_words("14:35:42", :ta)).to eq("பதிநான்கு மணி முப்பத்தைந்து நிமிடம் நாற்பத்திரண்டு விநாடி")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ta)).to eq(
        "இருபத்தொன்றாம் ஆகஸ்ட் இரண்டு ஆயிரம் இருபத்துநான்கு, பதிநான்கு மணி முப்பத்தைந்து நிமிடம் நாற்பத்திரண்டு விநாடி"
      )
    end
  end
end
