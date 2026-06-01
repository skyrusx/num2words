# frozen_string_literal: true

require "num2words"

RSpec.describe "Greek locale" do
  context "basic integers" do
    it "converts zero and ones" do
      expect(Num2words.to_words(0, :el)).to eq("μηδέν")
      expect(Num2words.to_words(1, :el)).to eq("ένας")
      expect(Num2words.to_words(2, :el)).to eq("δύο")
      expect(Num2words.to_words(5, :el)).to eq("πέντε")
    end

    it "converts tens and teens" do
      expect(Num2words.to_words(10, :el)).to eq("δέκα")
      expect(Num2words.to_words(11, :el)).to eq("έντεκα")
      expect(Num2words.to_words(19, :el)).to eq("δεκαεννέα")
      expect(Num2words.to_words(20, :el)).to eq("είκοσι")
      expect(Num2words.to_words(21, :el)).to eq("είκοσι ένας")
      expect(Num2words.to_words(24, :el)).to eq("είκοσι τέσσερις")
      expect(Num2words.to_words(35, :el)).to eq("τριάντα πέντε")
      expect(Num2words.to_words(99, :el)).to eq("ενενήντα εννέα")
    end

    it "converts hundreds" do
      expect(Num2words.to_words(100, :el)).to eq("εκατό")
      expect(Num2words.to_words(101, :el)).to eq("εκατό ένας")
      expect(Num2words.to_words(105, :el)).to eq("εκατό πέντε")
      expect(Num2words.to_words(124, :el)).to eq("εκατό είκοσι τέσσερις")
      expect(Num2words.to_words(999, :el)).to eq("εννιακόσια ενενήντα εννέα")
    end
  end

  context "thousands" do
    it "converts exact thousands and tails" do
      expect(Num2words.to_words(1_000, :el)).to eq("χίλια")
      expect(Num2words.to_words(2_000, :el)).to eq("δύο χιλιάδες")
      expect(Num2words.to_words(5_000, :el)).to eq("πέντε χιλιάδες")
      expect(Num2words.to_words(21_000, :el)).to eq("είκοσι μία χιλιάδες")
      expect(Num2words.to_words(22_000, :el)).to eq("είκοσι δύο χιλιάδες")
      expect(Num2words.to_words(25_000, :el)).to eq("είκοσι πέντε χιλιάδες")
      expect(Num2words.to_words(1_001, :el)).to eq("χίλια ένας")
      expect(Num2words.to_words(2_002, :el)).to eq("δύο χιλιάδες δύο")
      expect(Num2words.to_words(5_005, :el)).to eq("πέντε χιλιάδες πέντε")
    end
  end

  context "millions and billions" do
    it "converts exact scale values with neuter forms" do
      expect(Num2words.to_words(1_000_000, :el)).to eq("ένα εκατομμύριο")
      expect(Num2words.to_words(2_000_000, :el)).to eq("δύο εκατομμύρια")
      expect(Num2words.to_words(5_000_000, :el)).to eq("πέντε εκατομμύρια")
      expect(Num2words.to_words(1_000_000_000, :el)).to eq("ένα δισεκατομμύριο")
      expect(Num2words.to_words(2_000_000_000, :el)).to eq("δύο δισεκατομμύρια")
      expect(Num2words.to_words(5_000_000_000, :el)).to eq("πέντε δισεκατομμύρια")
    end

    it "converts compound scale values" do
      expect(Num2words.to_words(1_234_567, :el)).to eq("ένα εκατομμύριο διακόσια τριάντα τέσσερις χιλιάδες πεντακόσια εξήντα επτά")
      expect(Num2words.to_words(1_000_001, :el)).to eq("ένα εκατομμύριο ένας")
      expect(Num2words.to_words(2_021_004, :el)).to eq("δύο εκατομμύρια είκοσι μία χιλιάδες τέσσερις")
    end
  end

  context "feminine option" do
    it "changes one where applicable" do
      expect(Num2words.to_words(1, :el, feminine: true)).to eq("μία")
      expect(Num2words.to_words(2, :el, feminine: true)).to eq("δύο")
      expect(Num2words.to_words(21, :el, feminine: true)).to eq("είκοσι μία")
    end
  end

  context "negative numbers" do
    it "adds minus from locale" do
      expect(Num2words.to_words(-1, :el)).to eq("μείον ένας")
      expect(Num2words.to_words(-21, :el)).to eq("μείον είκοσι ένας")
      expect(Num2words.to_words(-1_000, :el)).to eq("μείον χίλια")
    end
  end

  context "string input" do
    it "recognizes integer strings" do
      expect(Num2words.to_words("007", :el)).to eq("επτά")
      expect(Num2words.to_words("-42", :el)).to eq("μείον σαράντα δύο")
    end

    it "recognizes decimal strings with dot and comma" do
      expect(Num2words.to_words("3.5", :el)).to eq("τρεις ολόκληρα πέντε δέκατα")
      expect(Num2words.to_words("3,5", :el)).to eq("τρεις ολόκληρα πέντε δέκατα")
    end
  end

  context "fractional numbers" do
    it "converts fraction style by default" do
      expect(Num2words.to_words(0.5, :el)).to eq("μηδέν ολόκληρα πέντε δέκατα")
      expect(Num2words.to_words(2.25, :el)).to eq("δύο ολόκληρα είκοσι πέντε εκατοστά")
      expect(Num2words.to_words(3.01, :el)).to eq("τρεις ολόκληρα ένας εκατοστό")
      expect(Num2words.to_words(-1.2, :el)).to eq("μείον ένας ολόκληρα δύο δέκατα")
    end

    it "uses informal joiner with joiner: :and" do
      expect(Num2words.to_words(0.5, :el, joiner: :and)).to eq("μηδέν και πέντε δέκατα")
      expect(Num2words.to_words(2.25, :el, joiner: :and)).to eq("δύο και είκοσι πέντε εκατοστά")
    end
  end

  context "range edges and large numbers" do
    it "converts large compound numbers" do
      expect(Num2words.to_words(9_876_543_210, :el)).to eq(
        "εννέα δισεκατομμύρια οκτακόσια εβδομήντα έξι εκατομμύρια πεντακόσια σαράντα τρεις χιλιάδες διακόσια δέκα"
      )
    end

    it "handles groups with teens" do
      expect(Num2words.to_words(11_011, :el)).to eq("έντεκα χιλιάδες έντεκα")
      expect(Num2words.to_words(1_011_011, :el)).to eq("ένα εκατομμύριο έντεκα χιλιάδες έντεκα")
    end
  end

  context "word case" do
    it "applies upper, downcase, capitalize and title" do
      base = "είκοσι ένας"
      expect(Num2words.to_words(21, :el, word_case: :upper)).to eq(base.upcase)
      expect(Num2words.to_words(21, :el, word_case: :downcase)).to eq(base)
      expect(Num2words.to_words(21, :el, word_case: :capitalize)).to eq("Είκοσι ένας")
      expect(Num2words.to_words(21, :el, word_case: :title)).to eq("Είκοσι Ένας")
    end
  end

  context "currency" do
    it "converts amounts and minor options" do
      expect(Num2words.to_currency(1, :el)).to eq("ένα ευρώ μηδέν λεπτά")
      expect(Num2words.to_currency(2, :el)).to eq("δύο ευρώ μηδέν λεπτά")
      expect(Num2words.to_currency("12.50", :el)).to eq("δώδεκα ευρώ πενήντα λεπτά")
      expect(Num2words.to_currency("12.50", :el, code: :BRL)).to eq("δώδεκα βραζιλιάνικα ρεάλ πενήντα σεντάβο")
      expect(Num2words.to_currency(12, :el, minor: :nonzero)).to eq("δώδεκα ευρώ")
      expect(Num2words.to_currency(12.5, :el, minor: :never)).to eq("δώδεκα ευρώ")
    end
  end

  context "date and time" do
    it "converts date, time and datetime" do
      expect(Num2words.to_words("2024-08-21", :el)).to eq("εικοστού πρώτου Αυγούστου δύο χιλιάδες είκοσι τέσσερα")
      expect(Num2words.to_words("2024-08-21", :el, date_case: :genitive)).to eq("εικοστού πρώτου Αυγούστου δύο χιλιάδες είκοσι τέσσερα")
      expect(Num2words.to_words("14:35:42", :el)).to eq("δεκατέσσερις ώρες τριάντα πέντε λεπτά σαράντα δύο δευτερόλεπτα")
      expect(Num2words.to_words("2024-08-21 14:35:42", :el)).to eq(
        "εικοστού πρώτου Αυγούστου δύο χιλιάδες είκοσι τέσσερα, δεκατέσσερις ώρες τριάντα πέντε λεπτά σαράντα δύο δευτερόλεπτα"
      )
    end
  end
end
