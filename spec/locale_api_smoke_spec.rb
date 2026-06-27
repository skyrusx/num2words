# frozen_string_literal: true

require "num2words"

RSpec.describe "locale API smoke coverage" do
  locales = Dir[File.expand_path("../config/locales/*.yml", __dir__)]
            .map { |file| File.basename(file, ".yml").to_sym }
            .sort

  def expect_words(result)
    expect(result).to be_a(String)
    expect(result).not_to be_empty
  end

  locales.each do |locale|
    it "supports the public API for #{locale}" do
      aggregate_failures locale do
        expect_words Num2words.to_words(123, locale)
        expect_words Num2words.to_words("3,5", locale)
        expect_words Num2words.to_words("2024-08-21", locale)
        expect_words Num2words.to_words("14:35:42", locale)
        expect_words Num2words.to_currency("12.50", locale)
      end
    end
  end
end
