# frozen_string_literal: true

require "num2words"

RSpec.describe "Kazakh locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :kz)).to eq("нөл")
      expect(Num2words.to_words(1, :kz)).to eq("бір")
      expect(Num2words.to_words(2, :kz)).to eq("екі")
      expect(Num2words.to_words(5, :kz)).to eq("бес")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :kz)).to eq("он")
      expect(Num2words.to_words(11, :kz)).to eq("он бір")
      expect(Num2words.to_words(19, :kz)).to eq("он тоғыз")
      expect(Num2words.to_words(20, :kz)).to eq("жиырма")
      expect(Num2words.to_words(21, :kz)).to eq("жиырма бір")
      expect(Num2words.to_words(24, :kz)).to eq("жиырма төрт")
      expect(Num2words.to_words(35, :kz)).to eq("отыз бес")
      expect(Num2words.to_words(99, :kz)).to eq("тоқсан тоғыз")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :kz)).to eq("жүз")
      expect(Num2words.to_words(101, :kz)).to eq("жүз бір")
      expect(Num2words.to_words(105, :kz)).to eq("жүз бес")
      expect(Num2words.to_words(124, :kz)).to eq("жүз жиырма төрт")
      expect(Num2words.to_words(999, :kz)).to eq("тоғыз жүз тоқсан тоғыз")
    end
  end

  context "thousands and large scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :kz)).to eq("бір мың")
      expect(Num2words.to_words(2_000, :kz)).to eq("екі мың")
      expect(Num2words.to_words(5_000, :kz)).to eq("бес мың")
      expect(Num2words.to_words(21_000, :kz)).to eq("жиырма бір мың")
      expect(Num2words.to_words(22_000, :kz)).to eq("жиырма екі мың")
      expect(Num2words.to_words(25_000, :kz)).to eq("жиырма бес мың")
      expect(Num2words.to_words(1_001, :kz)).to eq("бір мың бір")
      expect(Num2words.to_words(2_002, :kz)).to eq("екі мың екі")
      expect(Num2words.to_words(5_005, :kz)).to eq("бес мың бес")
    end

    it "converts million and billion values" do
      expect(Num2words.to_words(1_000_000, :kz)).to eq("бір миллион")
      expect(Num2words.to_words(2_000_000, :kz)).to eq("екі миллион")
      expect(Num2words.to_words(5_000_000, :kz)).to eq("бес миллион")
      expect(Num2words.to_words(1_000_000_000, :kz)).to eq("бір миллиард")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :kz)).to eq("бір миллион екі жүз отыз төрт мың бес жүз алпыс жеті")
      expect(Num2words.to_words(1_000_001, :kz)).to eq("бір миллион бір")
      expect(Num2words.to_words(2_021_004, :kz)).to eq("екі миллион жиырма бір мың төрт")
    end
  end

  context "feminine option" do
    it "does not change Kazakh output" do
      expect(Num2words.to_words(1, :kz, feminine: true)).to eq("бір")
      expect(Num2words.to_words(2, :kz, feminine: true)).to eq("екі")
      expect(Num2words.to_words(21, :kz, feminine: true)).to eq("жиырма бір")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :kz)).to eq("минус бір")
      expect(Num2words.to_words(-21, :kz)).to eq("минус жиырма бір")
      expect(Num2words.to_words(-1_000, :kz)).to eq("минус бір мың")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :kz)).to eq("жеті")
      expect(Num2words.to_words("-42", :kz)).to eq("минус қырық екі")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :kz)).to eq("үш бүтін бес оннан")
      expect(Num2words.to_words("3,5", :kz)).to eq("үш бүтін бес оннан")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :kz)).to eq("нөл бүтін бес оннан")
      expect(Num2words.to_words(2.25, :kz)).to eq("екі бүтін жиырма бес жүзден")
      expect(Num2words.to_words(3.01, :kz)).to eq("үш бүтін бір жүзден бір")
      expect(Num2words.to_words(-1.2, :kz)).to eq("минус бір бүтін екі оннан")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :kz, joiner: :and)).to eq("нөл және бес оннан")
      expect(Num2words.to_words(12.12, :kz, style: :decimal)).to eq("он екі үтір бір екі")
      expect(Num2words.to_words("3,05", :kz, style: :decimal)).to eq("үш үтір нөл бес")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :kz)).to eq(
        "тоғыз миллиард сегіз жүз жетпіс алты миллион бес жүз қырық үш мың екі жүз он"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :kz)).to eq("он бір мың он бір")
      expect(Num2words.to_words(1_011_011, :kz)).to eq("бір миллион он бір мың он бір")
    end
  end

  context "word case" do
    it "applies case options for Kazakh text" do
      base = "жиырма бір"
      expect(Num2words.to_words(21, :kz, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :kz, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :kz, word_case: :capitalize)).to eq("Жиырма бір")
      expect(Num2words.to_words(21, :kz, word_case: :title)).to eq("Жиырма Бір")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :kz)).to eq("бір теңге нөл тиын")
      expect(Num2words.to_currency(2, :kz)).to eq("екі теңге нөл тиын")
      expect(Num2words.to_currency("12.50", :kz)).to eq("он екі теңге елу тиын")
      expect(Num2words.to_currency("12.50", :kz, code: :BRL)).to eq("он екі бразилия реалы елу сентаво")
      expect(Num2words.to_currency(12, :kz, minor: :nonzero)).to eq("он екі теңге")
      expect(Num2words.to_currency(12.5, :kz, minor: :never)).to eq("он екі теңге")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :kz)).to eq("жиырма бірінші тамыз екі мың жиырма төрт")
      expect(Num2words.to_words("14:35:42", :kz)).to eq("он төрт сағат отыз бес минут қырық екі секунд")
      expect(Num2words.to_words("2024-08-21 14:35:42", :kz)).to eq(
        "жиырма бірінші тамыз екі мың жиырма төрт, он төрт сағат отыз бес минут қырық екі секунд"
      )
    end
  end
end
