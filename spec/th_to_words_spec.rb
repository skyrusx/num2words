# frozen_string_literal: true

require "num2words"

RSpec.describe "Thai locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :th)).to eq("ศูนย์")
      expect(Num2words.to_words(1, :th)).to eq("หนึ่ง")
      expect(Num2words.to_words(2, :th)).to eq("สอง")
      expect(Num2words.to_words(5, :th)).to eq("ห้า")
    end

    it "converts Thai-specific tens and teens" do
      expect(Num2words.to_words(10, :th)).to eq("สิบ")
      expect(Num2words.to_words(11, :th)).to eq("สิบเอ็ด")
      expect(Num2words.to_words(19, :th)).to eq("สิบเก้า")
      expect(Num2words.to_words(20, :th)).to eq("ยี่สิบ")
      expect(Num2words.to_words(21, :th)).to eq("ยี่สิบเอ็ด")
      expect(Num2words.to_words(24, :th)).to eq("ยี่สิบสี่")
      expect(Num2words.to_words(35, :th)).to eq("สามสิบห้า")
      expect(Num2words.to_words(99, :th)).to eq("เก้าสิบเก้า")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :th)).to eq("หนึ่งร้อย")
      expect(Num2words.to_words(101, :th)).to eq("หนึ่งร้อยหนึ่ง")
      expect(Num2words.to_words(105, :th)).to eq("หนึ่งร้อยห้า")
      expect(Num2words.to_words(124, :th)).to eq("หนึ่งร้อยยี่สิบสี่")
      expect(Num2words.to_words(999, :th)).to eq("เก้าร้อยเก้าสิบเก้า")
    end
  end

  context "thousands and scales" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :th)).to eq("หนึ่ง พัน")
      expect(Num2words.to_words(2_000, :th)).to eq("สอง พัน")
      expect(Num2words.to_words(5_000, :th)).to eq("ห้า พัน")
      expect(Num2words.to_words(21_000, :th)).to eq("ยี่สิบเอ็ด พัน")
      expect(Num2words.to_words(1_001, :th)).to eq("หนึ่ง พัน หนึ่ง")
      expect(Num2words.to_words(2_002, :th)).to eq("สอง พัน สอง")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_000_000, :th)).to eq("หนึ่ง ล้าน")
      expect(Num2words.to_words(2_000_000, :th)).to eq("สอง ล้าน")
      expect(Num2words.to_words(1_234_567, :th)).to eq("หนึ่ง ล้าน สองร้อยสามสิบสี่ พัน ห้าร้อยหกสิบเจ็ด")
      expect(Num2words.to_words(9_876_543_210, :th)).to eq(
        "เก้า พันล้าน แปดร้อยเจ็ดสิบหก ล้าน ห้าร้อยสี่สิบสาม พัน สองร้อยสิบ"
      )
    end
  end

  context "negative numbers and strings" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :th)).to eq("ลบ หนึ่ง")
      expect(Num2words.to_words(-21, :th)).to eq("ลบ ยี่สิบเอ็ด")
      expect(Num2words.to_words("-42", :th)).to eq("ลบ สี่สิบสอง")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :th)).to eq("สาม จุด ห้า ส่วนสิบ")
      expect(Num2words.to_words("3,5", :th)).to eq("สาม จุด ห้า ส่วนสิบ")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :th)).to eq("ศูนย์ จุด ห้า ส่วนสิบ")
      expect(Num2words.to_words(2.25, :th)).to eq("สอง จุด ยี่สิบห้า ส่วนร้อย")
      expect(Num2words.to_words(3.01, :th)).to eq("สาม จุด หนึ่ง ส่วนร้อย")
      expect(Num2words.to_words(-1.2, :th)).to eq("ลบ หนึ่ง จุด สอง ส่วนสิบ")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :th, joiner: :and)).to eq("ศูนย์ และ ห้า ส่วนสิบ")
      expect(Num2words.to_words(12.12, :th, style: :decimal)).to eq("สิบสอง จุด หนึ่ง สอง")
      expect(Num2words.to_words("3,05", :th, style: :decimal)).to eq("สาม จุด ศูนย์ ห้า")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :th)).to eq("หนึ่ง บาท ศูนย์ สตางค์")
      expect(Num2words.to_currency(2, :th)).to eq("สอง บาท ศูนย์ สตางค์")
      expect(Num2words.to_currency("12.50", :th)).to eq("สิบสอง บาท ห้าสิบ สตางค์")
      expect(Num2words.to_currency("12.50", :th, code: :BRL)).to eq("สิบสอง เรียลบราซิล ห้าสิบ เซนตาโว")
      expect(Num2words.to_currency(12, :th, minor: :nonzero)).to eq("สิบสอง บาท")
      expect(Num2words.to_currency(12.5, :th, minor: :never)).to eq("สิบสอง บาท")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :th)).to eq("ที่ยี่สิบเอ็ด สิงหาคม สอง พัน ยี่สิบสี่")
      expect(Num2words.to_words("14:35:42", :th)).to eq("สิบสี่ ชั่วโมง สามสิบห้า นาที สี่สิบสอง วินาที")
      expect(Num2words.to_words("2024-08-21 14:35:42", :th)).to eq(
        "ที่ยี่สิบเอ็ด สิงหาคม สอง พัน ยี่สิบสี่, สิบสี่ ชั่วโมง สามสิบห้า นาที สี่สิบสอง วินาที"
      )
    end
  end
end
