# num2words [![Gem Version](https://badge.fury.io/rb/num2words.svg)](https://badge.fury.io/rb/num2words)

Ruby-гем для преобразования чисел, дробей, денежных сумм, дат и времени в слова с учетом локальной грамматики.

---

## Возможности

- Числа: `Integer`, `Float`, числовые строки с точкой или запятой.
- Дроби: формальный стиль через `целых`/локальный аналог и разговорный `joiner: :and`.
- Decimal style: чтение дробной части по цифрам через `style: :decimal`.
- Валюты: единый каталог из 32 валют для каждой локали.
- Опции валют: `minor: :always | :nonzero | :never`.
- Даты, время и дата-время.
- Регистры вывода: `word_case: :upper | :downcase | :capitalize | :title`.
- Удобные методы для `Integer`, `Float`, `String`, `Date`, `Time`, `DateTime`.
- Интерактивная консоль `num2words-console`.

---

## Установка

Добавьте в `Gemfile`:

```ruby
gem "num2words"
```

Или установите напрямую:

```bash
gem install num2words
```

---

## Быстрый старт

```ruby
require "num2words"
```

### Числа

```ruby
123.to_words(:ru)
# => "сто двадцать три"

123.to_words(:en)
# => "one hundred twenty three"

"45,67".to_words(:ru)
# => "сорок пять целых шестьдесят семь сотых"

45.67.to_words(:ru, joiner: :and)
# => "сорок пять и шестьдесят семь сотых"

12.12.to_words(:en, style: :decimal)
# => "twelve point one two"
```

Универсальный вызов без core extensions:

```ruby
Num2words.to_words("3,5", :ru)
# => "три целых пять десятых"
```

### Валюта

```ruby
21.05.to_currency(:ru)
# => "двадцать один рубль пять копеек"

"21,05".to_currency(:ru)
# => "двадцать один рубль пять копеек"

Num2words.to_currency(BigDecimal("21.05"), :ru)
# => "двадцать один рубль пять копеек"

12.50.to_currency(:ru, code: :USD)
# => "двенадцать долларов пятьдесят центов"

1.to_currency(:ru, minor: :nonzero)
# => "один рубль"

1.25.to_currency(:ru, minor: :never)
# => "один рубль"
```

Поддерживаемые значения `minor:`:

- `:always` — всегда выводить младшую денежную единицу.
- `:nonzero` — выводить младшую единицу только когда она ненулевая.
- `:never` — не выводить младшую единицу.

### Дата

```ruby
"2024-08-21".to_words(:ru)
# => "двадцать первое августа две тысячи двадцать четвёртого года"

"2024-08-21".to_words(:ru, date_case: :genitive)
# => "двадцать первого августа две тысячи двадцать четвёртого года"

"2024-08-21".to_words(:en)
# => "the twenty-first of August, two thousand twenty four"
```

### Время

```ruby
"14:35:42".to_words(:ru)
# => "четырнадцать часов тридцать пять минут сорок две секунды"

"14:35:42".to_words(:ru, short: true)
# => "четырнадцать часов тридцать пять минут"

"14:35:42".to_words(:en)
# => "fourteen hours thirty five minutes forty two seconds"
```

### Дата и время

```ruby
"2024-08-21 14:35:42".to_words(:ru)
# => "двадцать первое августа две тысячи двадцать четвёртого года, четырнадцать часов тридцать пять минут сорок две секунды"

"2024-08-21 14:35:42".to_words(:en)
# => "the twenty-first of August, two thousand twenty four at fourteen hours thirty five minutes forty two seconds"
```

---

## Опции

- `locale: :ru` или второй аргумент `:ru` — выбор локали.
- `style: :fraction | :decimal` — стиль дробной части.
- `joiner: :default | :and` — формальный или разговорный соединитель дробей.
- `date_case: :default | :genitive` — падеж дня для дат, если локаль это поддерживает.
- `short: true` — краткая форма времени или даты/времени.
- `word_case: :default | :upper | :downcase | :capitalize | :title` — регистр результата.
- `minor: :always | :nonzero | :never` — вывод младшей денежной единицы.
- `code: :USD` — выбор валюты для `to_currency`.

---

## Консоль

Запуск из репозитория:

```bash
bin/console
```

Запуск после установки гема:

```bash
num2words-console
```

В консоли доступны обычные вызовы:

```ruby
Num2words.to_words(2025, :ru)
Num2words.to_currency("12.50", :en, code: :EUR)
"2024-08-21 14:35:42".to_words(:fr)
```

---

## Локали

Все локали поддерживают общий набор возможностей: числа, дроби, даты, время, дату-время и валюты. Грамматика и правила чтения чисел вынесены в соответствующие `Num2words::Locales::XX` модули.

Поддерживаемые локали:

```text
ar be bg bn cs da de el en es et fa fi fr gu he hi hr hu id it ja kn ko
kz lt lv ml mr ms nb nl pa pl pt ro ru sk sl sr sv sw ta te th tr uk ur
vi zh
```

Всего: 50 локалей.

### Валюты

Каждая локаль содержит одинаковый каталог из 32 валют:

```text
BDT BGN BRL BYN CNY CZK DKK EUR GBP HUF IDR ILS INR IRR JPY KES KRW
KZT MYR NOK PKR PLN RON RSD RUB SAR SEK THB TRY UAH USD VND
```

---

## Добавление локали

Новая локаль состоит из двух файлов:

- `config/locales/xx.yml` — данные: числа, даты, время, валюты, грамматика.
- `lib/num2words/locales/xx.rb` — языковые правила и hooks для converter.

После добавления локали стоит покрыть ее отдельным spec и добавить в `spec/currency_catalog_spec.rb`.

Подробная инструкция: [docs/locale_development.md](docs/locale_development.md).

---

## Тестирование

```bash
bundle exec rspec
```

---

## Roadmap

- [x] Поддержка чисел для всех локалей.
- [x] Поддержка дробей для всех локалей.
- [x] Поддержка дат и времени для всех локалей.
- [x] Единый каталог из 32 валют для всех локалей.
- [x] Интерактивная консоль.
- [ ] Дополнительная экспертная вычитка грамматики носителями языка.
- [ ] Расширение списка валют.
- [ ] Настраиваемые форматы валютного вывода.

---

## Лицензия

[MIT](LICENSE)
