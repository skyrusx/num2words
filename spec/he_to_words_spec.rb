# frozen_string_literal: true

require "num2words"

RSpec.describe "Hebrew locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :he)).to eq("אפס")
      expect(Num2words.to_words(1, :he)).to eq("אחד")
      expect(Num2words.to_words(2, :he)).to eq("שניים")
      expect(Num2words.to_words(5, :he)).to eq("חמישה")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :he)).to eq("עשר")
      expect(Num2words.to_words(11, :he)).to eq("אחת עשרה")
      expect(Num2words.to_words(19, :he)).to eq("תשע עשרה")
      expect(Num2words.to_words(20, :he)).to eq("עשרים")
      expect(Num2words.to_words(21, :he)).to eq("עשרים ואחד")
      expect(Num2words.to_words(24, :he)).to eq("עשרים וארבעה")
      expect(Num2words.to_words(35, :he)).to eq("שלושים וחמישה")
      expect(Num2words.to_words(99, :he)).to eq("תשעים ותשעה")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :he)).to eq("מאה")
      expect(Num2words.to_words(101, :he)).to eq("מאה אחד")
      expect(Num2words.to_words(105, :he)).to eq("מאה חמישה")
      expect(Num2words.to_words(124, :he)).to eq("מאה עשרים וארבעה")
      expect(Num2words.to_words(999, :he)).to eq("תשע מאות תשעים ותשעה")
    end
  end

  context "thousands and scale values" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :he)).to eq("אלף")
      expect(Num2words.to_words(2_000, :he)).to eq("אלפים")
      expect(Num2words.to_words(5_000, :he)).to eq("חמישה אלפים")
      expect(Num2words.to_words(21_000, :he)).to eq("עשרים ואחד אלפים")
      expect(Num2words.to_words(22_000, :he)).to eq("עשרים ושניים אלפים")
      expect(Num2words.to_words(25_000, :he)).to eq("עשרים וחמישה אלפים")
      expect(Num2words.to_words(1_001, :he)).to eq("אלף אחד")
      expect(Num2words.to_words(2_002, :he)).to eq("אלפים שניים")
      expect(Num2words.to_words(5_005, :he)).to eq("חמישה אלפים חמישה")
    end

    it "converts million and billion values" do
      expect(Num2words.to_words(1_000_000, :he)).to eq("מיליון")
      expect(Num2words.to_words(2_000_000, :he)).to eq("שניים מיליונים")
      expect(Num2words.to_words(5_000_000, :he)).to eq("חמישה מיליונים")
      expect(Num2words.to_words(1_000_000_000, :he)).to eq("מיליארד")
      expect(Num2words.to_words(2_000_000_000, :he)).to eq("שניים מיליארדים")
      expect(Num2words.to_words(5_000_000_000, :he)).to eq("חמישה מיליארדים")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :he)).to eq("מיליון מאתיים שלושים וארבעה אלפים חמש מאות שישים ושבעה")
      expect(Num2words.to_words(1_000_001, :he)).to eq("מיליון אחד")
      expect(Num2words.to_words(2_021_004, :he)).to eq("שניים מיליונים עשרים ואחד אלפים ארבעה")
    end
  end

  context "feminine option" do
    it "uses feminine forms" do
      expect(Num2words.to_words(1, :he, feminine: true)).to eq("אחת")
      expect(Num2words.to_words(2, :he, feminine: true)).to eq("שתיים")
      expect(Num2words.to_words(21, :he, feminine: true)).to eq("עשרים ואחת")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :he)).to eq("מינוס אחד")
      expect(Num2words.to_words(-21, :he)).to eq("מינוס עשרים ואחד")
      expect(Num2words.to_words(-1_000, :he)).to eq("מינוס אלף")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :he)).to eq("שבעה")
      expect(Num2words.to_words("-42", :he)).to eq("מינוס ארבעים ושניים")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :he)).to eq("שלושה שלמים חמש עשיריות")
      expect(Num2words.to_words("3,5", :he)).to eq("שלושה שלמים חמש עשיריות")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :he)).to eq("אפס שלמים חמש עשיריות")
      expect(Num2words.to_words(2.25, :he)).to eq("שניים שלמים עשרים וחמש מאיות")
      expect(Num2words.to_words(3.01, :he)).to eq("שלושה שלמים אחת מאית")
      expect(Num2words.to_words(-1.2, :he)).to eq("מינוס אחד שלמים שתיים עשיריות")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :he, joiner: :and)).to eq("אפס ו חמש עשיריות")
      expect(Num2words.to_words(12.12, :he, style: :decimal)).to eq("שתים עשרה נקודה אחד שניים")
      expect(Num2words.to_words("3,05", :he, style: :decimal)).to eq("שלושה נקודה אפס חמישה")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :he)).to eq(
        "תשעה מיליארדים שמונה מאות שבעים ושישה מיליונים חמש מאות ארבעים ושלושה אלפים מאתיים עשר"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :he)).to eq("אחת עשרה אלפים אחת עשרה")
      expect(Num2words.to_words(1_011_011, :he)).to eq("מיליון אחת עשרה אלפים אחת עשרה")
    end
  end

  context "word case" do
    it "applies case options without changing Hebrew text" do
      base = "עשרים ואחד"
      expect(Num2words.to_words(21, :he, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :he, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :he, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :he, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :he)).to eq("אחד שקל חדש אפס אגורות")
      expect(Num2words.to_currency(2, :he)).to eq("שניים שקלים חדשים אפס אגורות")
      expect(Num2words.to_currency("12.50", :he)).to eq("שתים עשרה שקלים חדשים חמישים אגורות")
      expect(Num2words.to_currency("12.50", :he, code: :BRL)).to eq("שתים עשרה ריאלים ברזילאיים חמישים סנטאבואים")
      expect(Num2words.to_currency(12, :he, minor: :nonzero)).to eq("שתים עשרה שקלים חדשים")
      expect(Num2words.to_currency(12.5, :he, minor: :never)).to eq("שתים עשרה שקלים חדשים")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :he)).to eq("עשרים ואחד אוגוסט אלפים עשרים וארבעה")
      expect(Num2words.to_words("14:35:42", :he)).to eq("ארבע עשרה שעות שלושים וחמש דקות ארבעים ושתיים שניות")
      expect(Num2words.to_words("2024-08-21 14:35:42", :he)).to eq(
        "עשרים ואחד אוגוסט אלפים עשרים וארבעה, ארבע עשרה שעות שלושים וחמש דקות ארבעים ושתיים שניות"
      )
    end
  end
end
