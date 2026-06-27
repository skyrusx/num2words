# Locale Development

This guide describes how to add or update a locale in `num2words`.

Each locale has two main files:

- `config/locales/xx.yml` - locale data for numbers, grammar, dates, time and currencies.
- `lib/num2words/locales/xx.rb` - language-specific rules used by `Num2words::Converter`.

Use an existing completed locale as a reference. For simple European plural rules, `ru`, `uk`, `be`, `pl`, `cs` are useful examples. For languages with 4-digit or regional grouping, check `ja`, `ko`, `zh`, `hi`, `pa`, `ur`.

## YAML Structure

The YAML root must match the locale code:

```yaml
xx:
  num2words:
    ones_masc: []
    ones_fem: []
    teens: []
    tens: []
    hundreds: []
    scales: []

    grammar:
      minus: ""
      conjunction: ""
      default_fraction: ""

    fractions:
      10: []
      100: []
      1000: []
      10000: []
      100000: []
      1000000: []
      10000000: []
      100000000: []
      1000000000: []

    numbers:
      ordinals:
        nominative:
          masculine: []
          feminine: []
          neuter: []
        default:
          masculine: []

    datetime:
      template: "%{date}, %{time}"

    date:
      template:
        default: "%{day} %{month} %{year}"
        nominative: "%{day} %{month} %{year}"
      months:
        default: []
        nominative: []

    time:
      template:
        hours_only: "%{hours}"
        hours_minutes: "%{hours} %{minutes}"
        hours_minutes_seconds: "%{hours} %{minutes} %{seconds}"
      words:
        hour: []
        minute: []
        second: []

    warnings:
      currency_not_available: "Currency %{currency} is not available for locale %{locale}."

    currencies:
      USD:
        major_unit: []
        minor_unit: []
        symbol: "$"
```

## Currency Catalog

Every completed locale must contain the same 32 currency codes:

```text
BDT BGN BRL BYN CNY CZK DKK EUR GBP HUF IDR ILS INR IRR JPY KES KRW
KZT MYR NOK PKR PLN RON RSD RUB SAR SEK THB TRY UAH USD VND
```

Each currency entry must include:

- `major_unit` - array of unit forms.
- `minor_unit` - array of minor unit forms.
- `symbol` - display symbol.

Example:

```yaml
USD:
  major_unit: ["dollar", "dollars", "dollars"]
  minor_unit: ["cent", "cents", "cents"]
  symbol: "$"
```

If the language does not use plural forms, repeat the same value three times.

## Locale Module

Each Ruby locale module must register itself:

```ruby
# frozen_string_literal: true

module Num2words
  module Locales
    module XX
      ONES_MASC = I18n.t("num2words.ones_masc", locale: :xx)
      ONES_FEM = I18n.t("num2words.ones_fem", locale: :xx)
      TEENS = I18n.t("num2words.teens", locale: :xx)
      TENS = I18n.t("num2words.tens", locale: :xx)
      HUNDREDS = I18n.t("num2words.hundreds", locale: :xx)
      SCALES = I18n.t("num2words.scales", locale: :xx)

      FRACTIONS = I18n.t("num2words.fractions", locale: :xx)
      GRAMMAR = I18n.t("num2words.grammar", locale: :xx)

      DATE = I18n.t("num2words.date", locale: :xx)
      DATE_TEMPLATE = I18n.t("num2words.date.template", locale: :xx)
      TIME = I18n.t("num2words.time", locale: :xx)
      TIME_TEMPLATE = I18n.t("num2words.time.template", locale: :xx)
      DATETIME_TEMPLATE = I18n.t("num2words.datetime.template", locale: :xx)

      ORDINALS = I18n.t("num2words.numbers.ordinals", locale: :xx)

      module_function
    end

    register :xx, XX
  end
end
```

## Common Hooks

`Converter` handles common flow and calls locale hooks when they exist.

Number hooks:

- `integer_to_words(number, feminine: false)` - fully custom integer conversion.
- `triple_to_words(number, scale_idx, feminine: false)` - conversion for a 0..999 group.
- `feminine_group?(scale_idx)` - whether a scale group uses feminine forms.
- `pluralize(number, singular, few, plural)` - local plural rule.

Fraction hooks:

- `minus_word`
- `fraction_joiner(joiner)`
- `default_fraction_word`
- `fraction_numerator_feminine?`
- `decimal_separator_word`
- `decimal_fraction_words(fraction_string)`
- `join_decimal_words(words)`
- `join_fraction_words(words)`

Date and time hooks:

- `date_day(day, format:, date_case:)`
- `date_year(year, format:)`
- `time_unit_feminine?(unit)`
- `time_number_words(number, unit:)`
- `join_time_words(number_words, unit_words)`

Currency hooks:

- `currency_major_feminine?(currency)`
- `currency_minor_feminine?(currency)`
- `currency_number_words(number, currency, unit:)`
- `join_currency_parts(parts)`

Use hooks only when the language needs them. If the common converter behavior is enough, keep the locale module smaller.

## Specs

Add a dedicated spec:

```text
spec/xx_to_words_spec.rb
```

Minimum coverage should include:

- zero and basic integers;
- tens, hundreds and scale values;
- large compound numbers;
- negative numbers;
- string integer input;
- decimal string input with dot and comma;
- fraction style and `joiner: :and`;
- `word_case`;
- `to_currency` with default currency, another currency and `minor:` options;
- date, time and datetime.

Then add the locale code to:

```text
spec/currency_catalog_spec.rb
```

The locale API smoke spec discovers YAML files automatically, so no manual update is needed there.

## Verification

Run targeted tests first:

```bash
bundle exec rspec spec/xx_to_words_spec.rb spec/currency_catalog_spec.rb spec/locale_api_smoke_spec.rb
```

Then run the full suite:

```bash
bundle exec rspec
```

Before release, also build the gem:

```bash
gem build num2words.gemspec
```

## Practical Checklist

- YAML root matches the locale code.
- Locale module registers with `register :xx, XX`.
- `GRAMMAR`, `FRACTIONS`, `DATE`, `TIME`, `DATETIME_TEMPLATE` and `ORDINALS` constants exist.
- All 32 currencies exist and have `major_unit`, `minor_unit`, `symbol`.
- Default currency is the first currency in YAML.
- Dates and times work through `Num2words.to_words`.
- Currency works through `Num2words.to_currency`.
- Full test suite passes.
