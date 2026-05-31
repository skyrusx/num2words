# frozen_string_literal: true

require "num2words"

RSpec.describe "Arabic locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :ar)).to eq("صفر")
      expect(Num2words.to_words(1, :ar)).to eq("واحد")
      expect(Num2words.to_words(2, :ar)).to eq("اثنان")
      expect(Num2words.to_words(5, :ar)).to eq("خمسة")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :ar)).to eq("عشرة")
      expect(Num2words.to_words(11, :ar)).to eq("أحد عشر")
      expect(Num2words.to_words(19, :ar)).to eq("تسعة عشر")
      expect(Num2words.to_words(20, :ar)).to eq("عشرون")
      expect(Num2words.to_words(21, :ar)).to eq("واحد وعشرون")
      expect(Num2words.to_words(24, :ar)).to eq("أربعة وعشرون")
      expect(Num2words.to_words(35, :ar)).to eq("خمسة وثلاثون")
      expect(Num2words.to_words(99, :ar)).to eq("تسعة وتسعون")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :ar)).to eq("مائة")
      expect(Num2words.to_words(101, :ar)).to eq("مائة وواحد")
      expect(Num2words.to_words(105, :ar)).to eq("مائة وخمسة")
      expect(Num2words.to_words(124, :ar)).to eq("مائة وأربعة وعشرون")
      expect(Num2words.to_words(999, :ar)).to eq("تسعمائة وتسعة وتسعون")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :ar)).to eq("ألف")
      expect(Num2words.to_words(2_000, :ar)).to eq("ألفان")
      expect(Num2words.to_words(5_000, :ar)).to eq("خمسة آلاف")
      expect(Num2words.to_words(21_000, :ar)).to eq("واحد وعشرون ألف")
      expect(Num2words.to_words(22_000, :ar)).to eq("اثنان وعشرون ألف")
      expect(Num2words.to_words(25_000, :ar)).to eq("خمسة وعشرون ألف")
      expect(Num2words.to_words(1_001, :ar)).to eq("ألف وواحد")
      expect(Num2words.to_words(2_002, :ar)).to eq("ألفان واثنان")
      expect(Num2words.to_words(5_005, :ar)).to eq("خمسة آلاف وخمسة")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :ar)).to eq("مليون")
      expect(Num2words.to_words(2_000_000, :ar)).to eq("مليونان")
      expect(Num2words.to_words(5_000_000, :ar)).to eq("خمسة ملايين")
      expect(Num2words.to_words(1_000_000_000, :ar)).to eq("مليار")
      expect(Num2words.to_words(2_000_000_000, :ar)).to eq("ملياران")
      expect(Num2words.to_words(5_000_000_000, :ar)).to eq("خمسة مليارات")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :ar)).to eq("مليون ومائتان وأربعة وثلاثون ألف وخمسمائة وسبعة وستون")
      expect(Num2words.to_words(1_000_001, :ar)).to eq("مليون وواحد")
      expect(Num2words.to_words(2_021_004, :ar)).to eq("مليونان وواحد وعشرون ألف وأربعة")
    end
  end

  context "feminine option" do
    it "uses feminine ones where applicable" do
      expect(Num2words.to_words(1, :ar, feminine: true)).to eq("واحدة")
      expect(Num2words.to_words(2, :ar, feminine: true)).to eq("اثنتان")
      expect(Num2words.to_words(21, :ar, feminine: true)).to eq("واحدة وعشرون")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :ar)).to eq("ناقص واحد")
      expect(Num2words.to_words(-21, :ar)).to eq("ناقص واحد وعشرون")
      expect(Num2words.to_words(-1_000, :ar)).to eq("ناقص ألف")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :ar)).to eq("سبعة")
      expect(Num2words.to_words("-42", :ar)).to eq("ناقص اثنان وأربعون")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :ar)).to eq("ثلاثة فاصلة خمسة أعشار")
      expect(Num2words.to_words("3,5", :ar)).to eq("ثلاثة فاصلة خمسة أعشار")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :ar)).to eq("صفر فاصلة خمسة أعشار")
      expect(Num2words.to_words(2.25, :ar)).to eq("اثنان فاصلة خمسة وعشرون مِئويّة")
      expect(Num2words.to_words(3.01, :ar)).to eq("ثلاثة فاصلة واحد مِئويّة")
      expect(Num2words.to_words(-1.2, :ar)).to eq("ناقص واحد فاصلة اثنان عُشران")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :ar, joiner: :and)).to eq("صفر وخمسة أعشار")
      expect(Num2words.to_words(2.25, :ar, joiner: :and)).to eq("اثنان وخمسة وعشرون مِئويّة")
    end

    it "converts decimal style" do
      expect(Num2words.to_words(12.12, :ar, style: :decimal)).to eq("اثنا عشر فاصلة واحد اثنان")
      expect(Num2words.to_words("3,05", :ar, style: :decimal)).to eq("ثلاثة فاصلة صفر خمسة")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :ar)).to eq(
        "تسعة مليارات وثمانمائة وستة وسبعون مليون وخمسمائة وثلاثة وأربعون ألف ومائتان وعشرة"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :ar)).to eq("أحد عشر ألف وأحد عشر")
      expect(Num2words.to_words(1_011_011, :ar)).to eq("مليون وأحد عشر ألف وأحد عشر")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title without changing Arabic letters" do
      base = "واحد وعشرون"
      expect(Num2words.to_words(21, :ar, word_case: :upper)).to eq(base)
      expect(Num2words.to_words(21, :ar, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :ar, word_case: :capitalize)).to eq(base)
      expect(Num2words.to_words(21, :ar, word_case: :title)).to eq(base)
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :ar)).to eq("واحد ريال صفر هللات")
      expect(Num2words.to_currency(2, :ar)).to eq("اثنان ريالان صفر هللات")
      expect(Num2words.to_currency("12.50", :ar)).to eq("اثنا عشر ريال خمسون هللة")
      expect(Num2words.to_currency(12, :ar, minor: :nonzero)).to eq("اثنا عشر ريال")
      expect(Num2words.to_currency(12.5, :ar, minor: :never)).to eq("اثنا عشر ريال")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :ar)).to eq("الحادي والعشرون أغسطس ألفان وأربعة وعشرون م")
      expect(Num2words.to_words("14:35:42", :ar)).to eq("أربعة عشر ساعة خمس وثلاثون دقيقة اثنتان وأربعون ثانية")
      expect(Num2words.to_words("2024-08-21 14:35:42", :ar)).to eq(
        "الحادي والعشرون أغسطس ألفان وأربعة وعشرون م، أربعة عشر ساعة خمس وثلاثون دقيقة اثنتان وأربعون ثانية"
      )
    end
  end
end
