# frozen_string_literal: true

require "yaml"

RSpec.describe "locale structure" do
  locale_files = Dir[File.expand_path("../config/locales/*.yml", __dir__)].sort

  let(:required_sections) do
    %w[
      ones_masc ones_fem teens tens hundreds scales grammar fractions numbers
      datetime date time warnings currencies
    ]
  end

  let(:required_grammar_keys) do
    %w[minus conjunction default_fraction]
  end

  let(:required_fraction_denominators) do
    %w[10 100 1000 10000 100000 1000000 10000000 100000000 1000000000]
  end

  let(:required_currency_keys) do
    %w[major_unit minor_unit symbol]
  end

  locale_files.each do |file|
    locale = File.basename(file, ".yml")

    it "has required top-level sections for #{locale}" do
      data = YAML.load_file(file)
      locale_data = data.dig(locale, "num2words")

      expect(locale_data).to be_a(Hash)
      expect(locale_data.keys).to include(*required_sections)
    end

    it "has complete number arrays for #{locale}" do
      locale_data = YAML.load_file(file).dig(locale, "num2words")

      expect(locale_data.fetch("ones_masc").size).to eq(10)
      expect(locale_data.fetch("ones_fem").size).to eq(10)
      expect(locale_data.fetch("teens").size).to eq(10)
      expect(locale_data.fetch("tens").size).to be >= 10
      expect(locale_data.fetch("hundreds").size).to eq(10)
      expect(locale_data.fetch("scales").size).to be >= 5
    end

    it "has required grammar and fraction data for #{locale}" do
      locale_data = YAML.load_file(file).dig(locale, "num2words")
      grammar = locale_data.fetch("grammar")
      fractions = locale_data.fetch("fractions")

      expect(grammar.keys.map(&:to_s)).to include(*required_grammar_keys)
      expect(fractions.keys.map(&:to_s)).to include(*required_fraction_denominators)

      required_fraction_denominators.each do |denominator|
        forms = fractions.fetch(denominator) { fractions.fetch(denominator.to_i) }

        expect(forms).to be_an(Array)
        expect(forms.size).to eq(3)
        expect(forms).to all(be_a(String))
      end
    end

    it "has date, time and ordinal data for #{locale}" do
      locale_data = YAML.load_file(file).dig(locale, "num2words")
      ordinals = locale_data.dig("numbers", "ordinals")
      date = locale_data.fetch("date")
      time = locale_data.fetch("time")

      expect(ordinals).to be_a(Hash)
      expect(ordinals.dig("default", "masculine").size).to be >= 31

      expect(date.dig("template", "default")).to be_a(String)
      expect(date.dig("months", "default").size).to eq(12)

      expect(time.dig("template", "hours_only")).to be_a(String)
      expect(time.dig("template", "hours_minutes")).to be_a(String)
      expect(time.dig("template", "hours_minutes_seconds")).to be_a(String)
      expect(time.dig("words", "hour").size).to eq(3)
      expect(time.dig("words", "minute").size).to eq(3)
      expect(time.dig("words", "second").size).to eq(3)
    end

    it "has well-formed currency entries for #{locale}" do
      currencies = YAML.load_file(file).dig(locale, "num2words", "currencies")

      currencies.each do |code, currency|
        expect(code).to match(/\A[A-Z]{3}\z/)
        expect(currency.keys).to include(*required_currency_keys)
        expect(currency.fetch("major_unit").size).to eq(3)
        expect(currency.fetch("minor_unit").size).to eq(3)
        expect(currency.fetch("symbol")).to be_a(String)
        expect(currency.fetch("symbol")).not_to be_empty
      end
    end
  end
end
