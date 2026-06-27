# Разработка локалей

Эта инструкция описывает, как добавить новую локаль или актуализировать существующую в `num2words`.

Каждая локаль состоит из двух основных файлов:

- `config/locales/xx.yml` - данные локали: числа, грамматика, даты, время и валюты.
- `lib/num2words/locales/xx.rb` - языковые правила, которые использует `Num2words::Converter`.

В качестве примера лучше брать уже завершенные локали. Для языков с простыми европейскими правилами множественного числа подойдут `ru`, `uk`, `be`, `pl`, `cs`. Для языков с 4-значной или региональной группировкой смотри `ja`, `ko`, `zh`, `hi`, `pa`, `ur`.

## Структура YAML

Корневой ключ YAML должен совпадать с кодом локали:

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

## Каталог валют

Каждая завершенная локаль должна содержать одинаковый набор из 32 валют:

```text
BDT BGN BRL BYN CNY CZK DKK EUR GBP HUF IDR ILS INR IRR JPY KES KRW
KZT MYR NOK PKR PLN RON RSD RUB SAR SEK THB TRY UAH USD VND
```

Каждая валюта должна содержать:

- `major_unit` - формы основной денежной единицы.
- `minor_unit` - формы младшей денежной единицы.
- `symbol` - символ валюты.

Пример:

```yaml
USD:
  major_unit: ["доллар", "доллара", "долларов"]
  minor_unit: ["цент", "цента", "центов"]
  symbol: "$"
```

Если в языке нет склонения по числу, повторить одно и то же значение три раза.

## Ruby-модуль локали

Каждый Ruby-модуль локали должен зарегистрировать себя:

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

## Основные hooks

`Converter` отвечает за общий поток выполнения и вызывает методы локали, если они определены.

Hooks для чисел:

- `integer_to_words(number, feminine: false)` - полностью кастомное преобразование целых чисел.
- `triple_to_words(number, scale_idx, feminine: false)` - преобразование группы 0..999.
- `feminine_group?(scale_idx)` - нужно ли использовать женский род для группы разрядов.
- `pluralize(number, singular, few, plural)` - локальное правило множественного числа.

Hooks для дробей:

- `minus_word`
- `fraction_joiner(joiner)`
- `default_fraction_word`
- `fraction_numerator_feminine?`
- `decimal_separator_word`
- `decimal_fraction_words(fraction_string)`
- `join_decimal_words(words)`
- `join_fraction_words(words)`

Hooks для даты и времени:

- `date_day(day, format:, date_case:)`
- `date_year(year, format:)`
- `time_unit_feminine?(unit)`
- `time_number_words(number, unit:)`
- `join_time_words(number_words, unit_words)`

Hooks для валют:

- `currency_major_feminine?(currency)`
- `currency_minor_feminine?(currency)`
- `currency_number_words(number, currency, unit:)`
- `join_currency_parts(parts)`

Добавлять hook только если язык действительно требует отдельного поведения. Если общего поведения converter достаточно, модуль локали лучше оставить проще.

## Тесты

Для каждой локали нужен отдельный spec:

```text
spec/xx_to_words_spec.rb
```

Минимальное покрытие:

- ноль и базовые целые числа;
- десятки, сотни и разряды;
- большие составные числа;
- отрицательные числа;
- целое число строкой;
- дробная строка с точкой и запятой;
- дроби и `joiner: :and`;
- `word_case`;
- `to_currency` с валютой по умолчанию, другой валютой и опциями `minor:`;
- дата, время и дата-время.

После добавления локали добавть ее код в:

```text
spec/currency_catalog_spec.rb
```

`locale_api_smoke_spec` находит YAML-файлы автоматически, поэтому вручную обновлять его не нужно.

## Проверка

Сначала запустить целевые тесты:

```bash
bundle exec rspec spec/xx_to_words_spec.rb spec/currency_catalog_spec.rb spec/locale_api_smoke_spec.rb
```

Потом полный набор:

```bash
bundle exec rspec
```

Перед релизом также проверить сборку гема:

```bash
gem build num2words.gemspec
```

## Практический чеклист

- Корневой ключ YAML совпадает с кодом локали.
- Ruby-модуль зарегистрирован через `register :xx, XX`.
- Есть константы `GRAMMAR`, `FRACTIONS`, `DATE`, `TIME`, `DATETIME_TEMPLATE`, `ORDINALS`.
- Все 32 валюты есть и содержат `major_unit`, `minor_unit`, `symbol`.
- Валюта по умолчанию стоит первой в YAML.
- Даты и время работают через `Num2words.to_words`.
- Валюты работают через `Num2words.to_currency`.
- Полный набор тестов проходит.
