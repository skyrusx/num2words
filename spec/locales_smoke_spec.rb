# frozen_string_literal: true

require "num2words"

RSpec.describe "locale smoke coverage" do
  locales = Dir[File.expand_path("../config/locales/*.yml", __dir__)]
            .map { |file| File.basename(file, ".yml").to_sym }
            .sort

  known_broken_locales = {
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
