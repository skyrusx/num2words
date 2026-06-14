# frozen_string_literal: true

require "num2words"

RSpec.describe "Persian locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :fa)).to eq("صفر")
      expect(Num2words.to_words(1, :fa)).to eq("یک")
      expect(Num2words.to_words(2, :fa)).to eq("دو")
      expect(Num2words.to_words(5, :fa)).to eq("پنج")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :fa)).to eq("ده")
      expect(Num2words.to_words(11, :fa)).to eq("یازده")
      expect(Num2words.to_words(19, :fa)).to eq("نوزده")
      expect(Num2words.to_words(20, :fa)).to eq("بیست")
      expect(Num2words.to_words(21, :fa)).to eq("بیست و یک")
      expect(Num2words.to_words(24, :fa)).to eq("بیست و چهار")
      expect(Num2words.to_words(35, :fa)).to eq("سی و پنج")
      expect(Num2words.to_words(99, :fa)).to eq("نود و نه")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :fa)).to eq("صد")
      expect(Num2words.to_words(101, :fa)).to eq("صد و یک")
      expect(Num2words.to_words(105, :fa)).to eq("صد و پنج")
      expect(Num2words.to_words(124, :fa)).to eq("صد و بیست و چهار")
      expect(Num2words.to_words(999, :fa)).to eq("نهصد و نود و نه")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :fa)).to eq("هزار")
      expect(Num2words.to_words(2_000, :fa)).to eq("دو هزار")
      expect(Num2words.to_words(5_000, :fa)).to eq("پنج هزار")
      expect(Num2words.to_words(21_000, :fa)).to eq("بیست و یک هزار")
      expect(Num2words.to_words(22_000, :fa)).to eq("بیست و دو هزار")
      expect(Num2words.to_words(25_000, :fa)).to eq("بیست و پنج هزار")
      expect(Num2words.to_words(1_001, :fa)).to eq("هزار یک")
      expect(Num2words.to_words(2_002, :fa)).to eq("دو هزار دو")
      expect(Num2words.to_words(5_005, :fa)).to eq("پنج هزار پنج")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :fa)).to eq("یک میلیون")
      expect(Num2words.to_words(2_000_000, :fa)).to eq("دو میلیون")
      expect(Num2words.to_words(5_000_000, :fa)).to eq("پنج میلیون")
      expect(Num2words.to_words(1_000_000_000, :fa)).to eq("یک میلیارد")
      expect(Num2words.to_words(2_000_000_000, :fa)).to eq("دو میلیارد")
      expect(Num2words.to_words(5_000_000_000, :fa)).to eq("پنج میلیارد")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :fa)).to eq("یک میلیون دویست و سی و چهار هزار پانصد و شصت و هفت")
      expect(Num2words.to_words(1_000_001, :fa)).to eq("یک میلیون یک")
      expect(Num2words.to_words(2_021_004, :fa)).to eq("دو میلیون بیست و یک هزار چهار")
    end
  end

  context "feminine option" do
    it "does not change Persian output" do
      expect(Num2words.to_words(1, :fa, feminine: true)).to eq("یک")
      expect(Num2words.to_words(2, :fa, feminine: true)).to eq("دو")
      expect(Num2words.to_words(21, :fa, feminine: true)).to eq("بیست و یک")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :fa)).to eq("منفی یک")
      expect(Num2words.to_words(-21, :fa)).to eq("منفی بیست و یک")
      expect(Num2words.to_words(-1_000, :fa)).to eq("منفی هزار")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :fa)).to eq("هفت")
      expect(Num2words.to_words("-42", :fa)).to eq("منفی چهل و دو")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :fa)).to eq("سه و پنج دهم")
      expect(Num2words.to_words("3,5", :fa)).to eq("سه و پنج دهم")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :fa)).to eq("صفر و پنج دهم")
      expect(Num2words.to_words(2.25, :fa)).to eq("دو و بیست و پنج صدم")
      expect(Num2words.to_words(3.01, :fa)).to eq("سه و یک صدم")
      expect(Num2words.to_words(-1.2, :fa)).to eq("منفی یک و دو دهم")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :fa, style: :decimal)).to eq("دوازده ممیز یک دو")
      expect(Num2words.to_words("3,05", :fa, style: :decimal)).to eq("سه ممیز صفر پنج")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :fa)).to eq(
        "نه میلیارد هشتصد و هفتاد و شش میلیون پانصد و چهل و سه هزار دویست و ده"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :fa)).to eq("یازده هزار یازده")
      expect(Num2words.to_words(1_011_011, :fa)).to eq("یک میلیون یازده هزار یازده")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "بیست و یک"
      expect(Num2words.to_words(21, :fa, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :fa, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :fa, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :fa, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :fa)).to eq("یک ریال صفر دینار")
      expect(Num2words.to_currency(2, :fa)).to eq("دو ریال صفر دینار")
      expect(Num2words.to_currency("12.50", :fa, code: :USD)).to eq("دوازده دلار پنجاه سنت")
      expect(Num2words.to_currency("12.50", :fa, code: :BRL)).to eq("دوازده رئال برزیل پنجاه سنتاوو")
      expect(Num2words.to_currency(12, :fa, code: :USD, minor: :nonzero)).to eq("دوازده دلار")
      expect(Num2words.to_currency(12.5, :fa, code: :USD, minor: :never)).to eq("دوازده دلار")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :fa)).to eq("بیست و یکم اوت دو هزار بیست و چهار")
      expect(Num2words.to_words("14:35:42", :fa)).to eq("چهارده ساعت سی و پنج دقیقه چهل و دو ثانیه")
      expect(Num2words.to_words("2024-08-21 14:35:42", :fa)).to eq(
        "بیست و یکم اوت دو هزار بیست و چهار، چهارده ساعت سی و پنج دقیقه چهل و دو ثانیه"
      )
    end
  end
end
