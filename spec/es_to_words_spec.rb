# frozen_string_literal: true

require "num2words"

RSpec.describe "Spanish locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :es)).to eq("cero")
      expect(Num2words.to_words(1, :es)).to eq("uno")
      expect(Num2words.to_words(2, :es)).to eq("dos")
      expect(Num2words.to_words(5, :es)).to eq("cinco")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :es)).to eq("diez")
      expect(Num2words.to_words(11, :es)).to eq("once")
      expect(Num2words.to_words(19, :es)).to eq("diecinueve")
      expect(Num2words.to_words(20, :es)).to eq("veinte")
      expect(Num2words.to_words(21, :es)).to eq("veintiuno")
      expect(Num2words.to_words(24, :es)).to eq("veinticuatro")
      expect(Num2words.to_words(35, :es)).to eq("treinta y cinco")
      expect(Num2words.to_words(99, :es)).to eq("noventa y nueve")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :es)).to eq("cien")
      expect(Num2words.to_words(101, :es)).to eq("ciento uno")
      expect(Num2words.to_words(105, :es)).to eq("ciento cinco")
      expect(Num2words.to_words(124, :es)).to eq("ciento veinticuatro")
      expect(Num2words.to_words(999, :es)).to eq("novecientos noventa y nueve")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :es)).to eq("mil")
      expect(Num2words.to_words(2_000, :es)).to eq("dos mil")
      expect(Num2words.to_words(5_000, :es)).to eq("cinco mil")
      expect(Num2words.to_words(21_000, :es)).to eq("veintiún mil")
      expect(Num2words.to_words(22_000, :es)).to eq("veintidós mil")
      expect(Num2words.to_words(25_000, :es)).to eq("veinticinco mil")
      expect(Num2words.to_words(1_001, :es)).to eq("mil uno")
      expect(Num2words.to_words(2_002, :es)).to eq("dos mil dos")
      expect(Num2words.to_words(5_005, :es)).to eq("cinco mil cinco")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :es)).to eq("un millón")
      expect(Num2words.to_words(2_000_000, :es)).to eq("dos millones")
      expect(Num2words.to_words(5_000_000, :es)).to eq("cinco millones")
      expect(Num2words.to_words(1_000_000_000, :es)).to eq("mil millones")
      expect(Num2words.to_words(2_000_000_000, :es)).to eq("dos mil millones")
      expect(Num2words.to_words(5_000_000_000, :es)).to eq("cinco mil millones")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :es)).to eq("un millón doscientos treinta y cuatro mil quinientos sesenta y siete")
      expect(Num2words.to_words(1_000_001, :es)).to eq("un millón uno")
      expect(Num2words.to_words(2_021_004, :es)).to eq("dos millones veintiún mil cuatro")
    end
  end

  context "feminine option" do
    it "changes one where applicable" do
      expect(Num2words.to_words(1, :es, feminine: true)).to eq("una")
      expect(Num2words.to_words(2, :es, feminine: true)).to eq("dos")
      expect(Num2words.to_words(21, :es, feminine: true)).to eq("veintiuna")
      expect(Num2words.to_words(201, :es, feminine: true)).to eq("doscientas una")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :es)).to eq("menos uno")
      expect(Num2words.to_words(-21, :es)).to eq("menos veintiuno")
      expect(Num2words.to_words(-1_000, :es)).to eq("menos mil")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :es)).to eq("siete")
      expect(Num2words.to_words("-42", :es)).to eq("menos cuarenta y dos")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :es)).to eq("tres con cinco décimas")
      expect(Num2words.to_words("3,5", :es)).to eq("tres con cinco décimas")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :es)).to eq("cero con cinco décimas")
      expect(Num2words.to_words(2.25, :es)).to eq("dos con veinticinco centésimas")
      expect(Num2words.to_words(3.01, :es)).to eq("tres con una centésima")
      expect(Num2words.to_words(-1.2, :es)).to eq("menos uno con dos décimas")
    end

    it "uses informal joiner with joiner: :and and decimal style" do
      expect(Num2words.to_words(0.5, :es, joiner: :and)).to eq("cero y cinco décimas")
      expect(Num2words.to_words(12.12, :es, style: :decimal)).to eq("doce coma uno dos")
      expect(Num2words.to_words("3,05", :es, style: :decimal)).to eq("tres coma cero cinco")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :es)).to eq(
        "nueve mil millones ochocientos setenta y seis millones quinientos cuarenta y tres mil doscientos diez"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :es)).to eq("once mil once")
      expect(Num2words.to_words(1_011_011, :es)).to eq("un millón once mil once")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "veintiuno"
      expect(Num2words.to_words(21, :es, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :es, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :es, word_case: :capitalize)).to eq("Veintiuno")
      expect(Num2words.to_words(21, :es, word_case: :title)).to eq("Veintiuno")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :es)).to eq("un euro cero céntimos")
      expect(Num2words.to_currency(2, :es)).to eq("dos euros cero céntimos")
      expect(Num2words.to_currency("12.50", :es)).to eq("doce euros cincuenta céntimos")
      expect(Num2words.to_currency("21.21", :es)).to eq("veintiún euros veintiún céntimos")
      expect(Num2words.to_currency("1.01", :es, code: :GBP)).to eq("una libra un penique")
      expect(Num2words.to_currency("12.50", :es, code: :BRL)).to eq("doce reales brasileños cincuenta centavos")
      expect(Num2words.to_currency(12, :es, minor: :nonzero)).to eq("doce euros")
      expect(Num2words.to_currency(12.5, :es, minor: :never)).to eq("doce euros")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :es)).to eq("veintiuno de agosto de dos mil veinticuatro")
      expect(Num2words.to_words("14:35:42", :es)).to eq("catorce horas treinta y cinco minutos cuarenta y dos segundos")
      expect(Num2words.to_words("21:21:21", :es)).to eq("veintiuna horas veintiún minutos veintiún segundos")
      expect(Num2words.to_words("2024-08-21 14:35:42", :es)).to eq(
        "veintiuno de agosto de dos mil veinticuatro, catorce horas treinta y cinco minutos cuarenta y dos segundos"
      )
    end
  end
end
