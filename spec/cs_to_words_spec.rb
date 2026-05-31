# frozen_string_literal: true

require "num2words"

RSpec.describe "Czech locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :cs)).to eq("nula")
      expect(Num2words.to_words(1, :cs)).to eq("jeden")
      expect(Num2words.to_words(2, :cs)).to eq("dva")
      expect(Num2words.to_words(5, :cs)).to eq("pět")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :cs)).to eq("deset")
      expect(Num2words.to_words(11, :cs)).to eq("jedenáct")
      expect(Num2words.to_words(19, :cs)).to eq("devatenáct")
      expect(Num2words.to_words(20, :cs)).to eq("dvacet")
      expect(Num2words.to_words(21, :cs)).to eq("dvacet jeden")
      expect(Num2words.to_words(24, :cs)).to eq("dvacet čtyři")
      expect(Num2words.to_words(35, :cs)).to eq("třicet pět")
      expect(Num2words.to_words(99, :cs)).to eq("devadesát devět")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :cs)).to eq("sto")
      expect(Num2words.to_words(101, :cs)).to eq("sto jeden")
      expect(Num2words.to_words(105, :cs)).to eq("sto pět")
      expect(Num2words.to_words(124, :cs)).to eq("sto dvacet čtyři")
      expect(Num2words.to_words(999, :cs)).to eq("devět set devadesát devět")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :cs)).to eq("tisíc")
      expect(Num2words.to_words(2_000, :cs)).to eq("dva tisíce")
      expect(Num2words.to_words(5_000, :cs)).to eq("pět tisíc")
      expect(Num2words.to_words(21_000, :cs)).to eq("dvacet jeden tisíc")
      expect(Num2words.to_words(22_000, :cs)).to eq("dvacet dva tisíce")
      expect(Num2words.to_words(25_000, :cs)).to eq("dvacet pět tisíc")
      expect(Num2words.to_words(1_001, :cs)).to eq("tisíc jeden")
      expect(Num2words.to_words(2_002, :cs)).to eq("dva tisíce dva")
      expect(Num2words.to_words(5_005, :cs)).to eq("pět tisíc pět")
    end
  end

  context "millions and billions" do
    it "converts exact scale values" do
      expect(Num2words.to_words(1_000_000, :cs)).to eq("jeden milion")
      expect(Num2words.to_words(2_000_000, :cs)).to eq("dva miliony")
      expect(Num2words.to_words(5_000_000, :cs)).to eq("pět milionů")
      expect(Num2words.to_words(1_000_000_000, :cs)).to eq("jedna miliarda")
      expect(Num2words.to_words(2_000_000_000, :cs)).to eq("dvě miliardy")
      expect(Num2words.to_words(5_000_000_000, :cs)).to eq("pět miliard")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :cs)).to eq("jeden milion dvě stě třicet čtyři tisíce pět set šedesát sedm")
      expect(Num2words.to_words(1_000_001, :cs)).to eq("jeden milion jeden")
      expect(Num2words.to_words(2_021_004, :cs)).to eq("dva miliony dvacet jeden tisíc čtyři")
    end
  end

  context "feminine option" do
    it "changes one and two where applicable" do
      expect(Num2words.to_words(1, :cs, feminine: true)).to eq("jedna")
      expect(Num2words.to_words(2, :cs, feminine: true)).to eq("dvě")
      expect(Num2words.to_words(21, :cs, feminine: true)).to eq("dvacet jedna")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :cs)).to eq("mínus jeden")
      expect(Num2words.to_words(-21, :cs)).to eq("mínus dvacet jeden")
      expect(Num2words.to_words(-1_000, :cs)).to eq("mínus tisíc")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :cs)).to eq("sedm")
      expect(Num2words.to_words("-42", :cs)).to eq("mínus čtyřicet dva")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :cs)).to eq("tři celých pět desetin")
      expect(Num2words.to_words("3,5", :cs)).to eq("tři celých pět desetin")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :cs)).to eq("nula celých pět desetin")
      expect(Num2words.to_words(2.25, :cs)).to eq("dva celých dvacet pět setin")
      expect(Num2words.to_words(3.01, :cs)).to eq("tři celých jedna setina")
      expect(Num2words.to_words(-1.2, :cs)).to eq("mínus jeden celých dvě desetiny")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :cs, joiner: :and)).to eq("nula a pět desetin")
      expect(Num2words.to_words(2.25, :cs, joiner: :and)).to eq("dva a dvacet pět setin")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :cs)).to eq(
        "devět miliard osm set sedmdesát šest milionů pět set čtyřicet tři tisíce dvě stě deset"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :cs)).to eq("jedenáct tisíc jedenáct")
      expect(Num2words.to_words(1_011_011, :cs)).to eq("jeden milion jedenáct tisíc jedenáct")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "dvacet jeden"
      expect(Num2words.to_words(21, :cs, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :cs, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :cs, word_case: :capitalize)).to eq("Dvacet jeden")
      expect(Num2words.to_words(21, :cs, word_case: :title)).to eq("Dvacet Jeden")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :cs)).to eq("jedna koruna nula haléřů")
      expect(Num2words.to_currency(2, :cs)).to eq("dvě koruny nula haléřů")
      expect(Num2words.to_currency("12.50", :cs)).to eq("dvanáct korun padesát haléřů")
      expect(Num2words.to_currency("12.50", :cs, code: :BRL)).to eq("dvanáct brazilských realů padesát centav")
      expect(Num2words.to_currency(12, :cs, minor: :nonzero)).to eq("dvanáct korun")
      expect(Num2words.to_currency(12.5, :cs, minor: :never)).to eq("dvanáct korun")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :cs)).to eq("dvacátého prvního srpna dva tisíce dvacet čtyři")
      expect(Num2words.to_words("2024-08-21", :cs, date_case: :genitive)).to eq("dvacátého prvního srpna dva tisíce dvacet čtyři")
      expect(Num2words.to_words("14:35:42", :cs)).to eq("čtrnáct hodin třicet pět minut čtyřicet dvě sekundy")
      expect(Num2words.to_words("2024-08-21 14:35:42", :cs)).to eq(
        "dvacátého prvního srpna dva tisíce dvacet čtyři, čtrnáct hodin třicet pět minut čtyřicet dvě sekundy"
      )
    end
  end
end
