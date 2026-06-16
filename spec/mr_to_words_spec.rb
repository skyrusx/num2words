# frozen_string_literal: true

require "num2words"

RSpec.describe "Marathi locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :mr)).to eq("शून्य")
      expect(Num2words.to_words(1, :mr)).to eq("एक")
      expect(Num2words.to_words(2, :mr)).to eq("दोन")
      expect(Num2words.to_words(5, :mr)).to eq("पाच")
    end

    it "converts Marathi-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :mr)).to eq("दहा")
      expect(Num2words.to_words(11, :mr)).to eq("अकरा")
      expect(Num2words.to_words(19, :mr)).to eq("एकोणीस")
      expect(Num2words.to_words(20, :mr)).to eq("वीस")
      expect(Num2words.to_words(21, :mr)).to eq("एकवीस")
      expect(Num2words.to_words(24, :mr)).to eq("चोवीस")
      expect(Num2words.to_words(35, :mr)).to eq("पस्तीस")
      expect(Num2words.to_words(99, :mr)).to eq("नव्व्याण्णव")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :mr)).to eq("शंभर")
      expect(Num2words.to_words(101, :mr)).to eq("शंभर एक")
      expect(Num2words.to_words(105, :mr)).to eq("शंभर पाच")
      expect(Num2words.to_words(124, :mr)).to eq("शंभर चोवीस")
      expect(Num2words.to_words(999, :mr)).to eq("नऊशे नव्व्याण्णव")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :mr)).to eq("एक हजार")
      expect(Num2words.to_words(2_000, :mr)).to eq("दोन हजार")
      expect(Num2words.to_words(5_000, :mr)).to eq("पाच हजार")
      expect(Num2words.to_words(21_000, :mr)).to eq("एकवीस हजार")
      expect(Num2words.to_words(22_000, :mr)).to eq("बावीस हजार")
      expect(Num2words.to_words(25_000, :mr)).to eq("पंचवीस हजार")
      expect(Num2words.to_words(1_001, :mr)).to eq("एक हजार एक")
      expect(Num2words.to_words(2_002, :mr)).to eq("दोन हजार दोन")
      expect(Num2words.to_words(5_005, :mr)).to eq("पाच हजार पाच")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :mr)).to eq("एक लाख")
      expect(Num2words.to_words(2_000_000, :mr)).to eq("वीस लाख")
      expect(Num2words.to_words(10_000_000, :mr)).to eq("एक कोटी")
      expect(Num2words.to_words(1_000_000_000, :mr)).to eq("एक अब्ज")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :mr)).to eq("बारा लाख चौतीस हजार पाचशे सदुसष्ट")
      expect(Num2words.to_words(1_000_001, :mr)).to eq("दहा लाख एक")
      expect(Num2words.to_words(2_021_004, :mr)).to eq("वीस लाख एकवीस हजार चार")
    end
  end

  context "feminine option" do
    it "does not change Marathi output" do
      expect(Num2words.to_words(1, :mr, feminine: true)).to eq("एक")
      expect(Num2words.to_words(2, :mr, feminine: true)).to eq("दोन")
      expect(Num2words.to_words(21, :mr, feminine: true)).to eq("एकवीस")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :mr)).to eq("वजा एक")
      expect(Num2words.to_words(-21, :mr)).to eq("वजा एकवीस")
      expect(Num2words.to_words(-1_000, :mr)).to eq("वजा एक हजार")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :mr)).to eq("सात")
      expect(Num2words.to_words("-42", :mr)).to eq("वजा बेचाळीस")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :mr)).to eq("तीन पूर्ण पाच दशांश")
      expect(Num2words.to_words("3,5", :mr)).to eq("तीन पूर्ण पाच दशांश")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :mr)).to eq("शून्य पूर्ण पाच दशांश")
      expect(Num2words.to_words(2.25, :mr)).to eq("दोन पूर्ण पंचवीस शतांश")
      expect(Num2words.to_words(3.01, :mr)).to eq("तीन पूर्ण एक शतांश")
      expect(Num2words.to_words(-1.2, :mr)).to eq("वजा एक पूर्ण दोन दशांश")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :mr, joiner: :and)).to eq("शून्य आणि पाच दशांश")
      expect(Num2words.to_words(12.12, :mr, style: :decimal)).to eq("बारा दशांश एक दोन")
      expect(Num2words.to_words("3,05", :mr, style: :decimal)).to eq("तीन दशांश शून्य पाच")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :mr)).to eq(
        "नऊ अब्ज सत्त्याऐंशी कोटी पासष्ट लाख त्रेचाळीस हजार दोनशे दहा"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :mr)).to eq("अकरा हजार अकरा")
      expect(Num2words.to_words(1_011_011, :mr)).to eq("दहा लाख अकरा हजार अकरा")
    end
  end

  context "word case" do
    it "applies case options without changing Marathi text" do
      base = "एकवीस"
      expect(Num2words.to_words(21, :mr, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :mr, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :mr, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :mr, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :mr)).to eq("एक रुपया शून्य पैसे")
      expect(Num2words.to_currency(2, :mr)).to eq("दोन रुपये शून्य पैसे")
      expect(Num2words.to_currency("12.50", :mr)).to eq("बारा रुपये पन्नास पैसे")
      expect(Num2words.to_currency("12.50", :mr, code: :BRL)).to eq("बारा ब्राझिलियन रिअल पन्नास सेंटावो")
      expect(Num2words.to_currency(12, :mr, minor: :nonzero)).to eq("बारा रुपये")
      expect(Num2words.to_currency(12.5, :mr, minor: :never)).to eq("बारा रुपये")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :mr)).to eq("एकविसाव्या ऑगस्ट दोन हजार चोवीस")
      expect(Num2words.to_words("14:35:42", :mr)).to eq("चौदा तास पस्तीस मिनिटे बेचाळीस सेकंद")
      expect(Num2words.to_words("2024-08-21 14:35:42", :mr)).to eq(
        "एकविसाव्या ऑगस्ट दोन हजार चोवीस, चौदा तास पस्तीस मिनिटे बेचाळीस सेकंद"
      )
    end
  end
end
