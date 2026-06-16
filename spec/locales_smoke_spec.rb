# frozen_string_literal: true

require "num2words"

RSpec.describe "locale smoke coverage" do
  locales = Dir[File.expand_path("../config/locales/*.yml", __dir__)]
            .map { |file| File.basename(file, ".yml").to_sym }
            .sort

  known_broken_locales = {
    mr: "legacy locale wrapper missing GRAMMAR",
    ms: "legacy locale wrapper missing GRAMMAR",
    nb: "locale wrapper file is named no.rb",
    nl: "legacy locale wrapper missing GRAMMAR",
    pa: "legacy locale wrapper missing GRAMMAR",
    pl: "legacy locale wrapper missing GRAMMAR",
    pt: "legacy locale wrapper missing GRAMMAR",
    ro: "legacy locale wrapper missing GRAMMAR",
    sk: "legacy locale wrapper missing GRAMMAR",
    sl: "legacy locale wrapper missing GRAMMAR",
    sr: "locale wrapper registers the wrong constant name",
    sv: "legacy locale wrapper missing GRAMMAR",
    sw: "legacy locale wrapper missing GRAMMAR",
    ta: "legacy locale wrapper missing GRAMMAR",
    te: "legacy locale wrapper missing GRAMMAR",
    th: "legacy locale wrapper missing GRAMMAR",
    tr: "legacy locale wrapper missing GRAMMAR",
    uk: "legacy locale wrapper missing GRAMMAR",
    ur: "legacy locale wrapper missing GRAMMAR",
    vi: "legacy locale wrapper missing GRAMMAR",
    zh: "legacy locale wrapper missing GRAMMAR"
  }

  locales.each do |locale|
    it "converts a basic integer for #{locale}" do
      pending known_broken_locales.fetch(locale) if known_broken_locales.key?(locale)

      result = Num2words.to_words(123, locale)

      expect(result).to be_a(String)
      expect(result).not_to be_empty
    end
  end
end
