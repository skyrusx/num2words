# frozen_string_literal: true

require "num2words"

RSpec.describe "Hindi locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :hi)).to eq("शून्य")
      expect(Num2words.to_words(1, :hi)).to eq("एक")
      expect(Num2words.to_words(2, :hi)).to eq("दो")
      expect(Num2words.to_words(5, :hi)).to eq("पाँच")
    end

    it "converts Hindi-specific numbers under one hundred" do
      expect(Num2words.to_words(10, :hi)).to eq("दस")
      expect(Num2words.to_words(11, :hi)).to eq("ग्यारह")
      expect(Num2words.to_words(19, :hi)).to eq("उन्नीस")
      expect(Num2words.to_words(20, :hi)).to eq("बीस")
      expect(Num2words.to_words(21, :hi)).to eq("इक्कीस")
      expect(Num2words.to_words(24, :hi)).to eq("चौबीस")
      expect(Num2words.to_words(35, :hi)).to eq("पैंतीस")
      expect(Num2words.to_words(99, :hi)).to eq("निन्यानवे")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :hi)).to eq("सौ")
      expect(Num2words.to_words(101, :hi)).to eq("सौ एक")
      expect(Num2words.to_words(105, :hi)).to eq("सौ पाँच")
      expect(Num2words.to_words(124, :hi)).to eq("सौ चौबीस")
      expect(Num2words.to_words(999, :hi)).to eq("नौ सौ निन्यानवे")
    end
  end

  context "thousands and Indian scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :hi)).to eq("एक हज़ार")
      expect(Num2words.to_words(2_000, :hi)).to eq("दो हज़ार")
      expect(Num2words.to_words(5_000, :hi)).to eq("पाँच हज़ार")
      expect(Num2words.to_words(21_000, :hi)).to eq("इक्कीस हज़ार")
      expect(Num2words.to_words(22_000, :hi)).to eq("बाईस हज़ार")
      expect(Num2words.to_words(25_000, :hi)).to eq("पच्चीस हज़ार")
      expect(Num2words.to_words(1_001, :hi)).to eq("एक हज़ार एक")
      expect(Num2words.to_words(2_002, :hi)).to eq("दो हज़ार दो")
      expect(Num2words.to_words(5_005, :hi)).to eq("पाँच हज़ार पाँच")
    end

    it "converts lakh, crore and arab values" do
      expect(Num2words.to_words(100_000, :hi)).to eq("एक लाख")
      expect(Num2words.to_words(2_000_000, :hi)).to eq("बीस लाख")
      expect(Num2words.to_words(10_000_000, :hi)).to eq("एक करोड़")
      expect(Num2words.to_words(1_000_000_000, :hi)).to eq("एक अरब")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :hi)).to eq("बारह लाख चौंतीस हज़ार पाँच सौ सड़सठ")
      expect(Num2words.to_words(1_000_001, :hi)).to eq("दस लाख एक")
      expect(Num2words.to_words(2_021_004, :hi)).to eq("बीस लाख इक्कीस हज़ार चार")
    end
  end

  context "feminine option" do
    it "does not change Hindi output" do
      expect(Num2words.to_words(1, :hi, feminine: true)).to eq("एक")
      expect(Num2words.to_words(2, :hi, feminine: true)).to eq("दो")
      expect(Num2words.to_words(21, :hi, feminine: true)).to eq("इक्कीस")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :hi)).to eq("माइनस एक")
      expect(Num2words.to_words(-21, :hi)).to eq("माइनस इक्कीस")
      expect(Num2words.to_words(-1_000, :hi)).to eq("माइनस एक हज़ार")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :hi)).to eq("सात")
      expect(Num2words.to_words("-42", :hi)).to eq("माइनस बयालीस")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :hi)).to eq("तीन पूर्ण पाँच दसवें")
      expect(Num2words.to_words("3,5", :hi)).to eq("तीन पूर्ण पाँच दसवें")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :hi)).to eq("शून्य पूर्ण पाँच दसवें")
      expect(Num2words.to_words(2.25, :hi)).to eq("दो पूर्ण पच्चीस सौवें")
      expect(Num2words.to_words(3.01, :hi)).to eq("तीन पूर्ण एक सौवाँ")
      expect(Num2words.to_words(-1.2, :hi)).to eq("माइनस एक पूर्ण दो दसवें")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :hi, joiner: :and)).to eq("शून्य और पाँच दसवें")
      expect(Num2words.to_words(12.12, :hi, style: :decimal)).to eq("बारह दशमलव एक दो")
      expect(Num2words.to_words("3,05", :hi, style: :decimal)).to eq("तीन दशमलव शून्य पाँच")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :hi)).to eq(
        "नौ अरब सत्तासी करोड़ पैंसठ लाख तैंतालीस हज़ार दो सौ दस"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :hi)).to eq("ग्यारह हज़ार ग्यारह")
      expect(Num2words.to_words(1_011_011, :hi)).to eq("दस लाख ग्यारह हज़ार ग्यारह")
    end
  end

  context "word case" do
    it "applies case options without changing Hindi text" do
      base = "इक्कीस"
      expect(Num2words.to_words(21, :hi, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :hi, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :hi, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :hi, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :hi)).to eq("एक रुपया शून्य पैसे")
      expect(Num2words.to_currency(2, :hi)).to eq("दो रुपये शून्य पैसे")
      expect(Num2words.to_currency("12.50", :hi)).to eq("बारह रुपये पचास पैसे")
      expect(Num2words.to_currency("12.50", :hi, code: :BRL)).to eq("बारह ब्राज़ीलियाई रियल पचास सेंटावो")
      expect(Num2words.to_currency(12, :hi, minor: :nonzero)).to eq("बारह रुपये")
      expect(Num2words.to_currency(12.5, :hi, minor: :never)).to eq("बारह रुपये")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :hi)).to eq("इक्कीसवें अगस्त दो हज़ार चौबीस")
      expect(Num2words.to_words("14:35:42", :hi)).to eq("चौदह घंटे पैंतीस मिनट बयालीस सेकंड")
      expect(Num2words.to_words("2024-08-21 14:35:42", :hi)).to eq(
        "इक्कीसवें अगस्त दो हज़ार चौबीस, चौदह घंटे पैंतीस मिनट बयालीस सेकंड"
      )
    end
  end
end
