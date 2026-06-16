# frozen_string_literal: true

require "yaml"

RSpec.describe "currency catalog" do
  let(:expected_currencies) do
    %w[
      BDT BGN BRL BYN CNY CZK DKK EUR GBP HUF IDR ILS INR IRR JPY KES KRW
      KZT MYR NOK PKR PLN RON RSD RUB SAR SEK THB TRY UAH USD VND
    ]
  end

  %w[ru en fr ar be bg bn cs da de el es et fa fi gu he hi hr hu id it ja kn ko kz lt lv ml mr ms].each do |locale|
    it "has a complete unique currency list for #{locale}" do
      data = YAML.load_file(File.expand_path("../config/locales/#{locale}.yml", __dir__))
      currencies = data.dig(locale, "num2words", "currencies")
      keys = currencies.keys

      expect(keys.uniq).to eq(keys)
      expect(keys.sort).to eq(expected_currencies.sort)
      expect(currencies.fetch("BRL")).to include("major_unit", "minor_unit", "symbol")
    end
  end
end
