# Changelog

Все заметные изменения в этом проекте будут документироваться в этом файле.

Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.0.0/),  
и этот проект использует [Semantic Versioning](https://semver.org/lang/ru/).

---

## [Unreleased]

- Добавление новых локалей (планируется расширение поддерживаемых языков).
- Оптимизация производительности при больших числах.
- Улучшения документации.

---

## [0.1.5] - 2025-08-22
### Added
- Расширение `Time#to_words`, возможность преобразовать строки с временем
```ruby
"14:35:42".to_words(:ru)
# => "четырнадцать часов тридцать пять минут сорок две секунды"
```
- Добавлен параметр `short: true` для `time` и `datetime`
Возвращает краткий вариант записи для time (`HH:MM`)
```ruby
"14:35:42".to_words(:ru, short: true)
# => "четырнадцать часов тридцать пять минут" 
```
Возвращает краткий вариант записи для datetime на выбор - дата или время
```ruby
"2024-08-21 14:35:42".to_words(:ru, :time)
# => "двадцать первого августа две тысячи двадцать четвёртого года"
```
- Поддержка перевода времени в разных форматах:
  - `:hours_only` — только часы
  - `:hours_minutes` — часы и минуты
  - `:hours_minutes_seconds` — часы, минуты и секунды

## [0.1.4] - 2025-08-21
### Added
- Расширение `String#to_words`, возможность преобразовать строки с датами
```ruby
"21.08.2025".to_words(:ru)
# => "двадцать первое августа две тысячи двадцать пятого года"

"21.08.2025".to_words(:en)
# => "the twenty-first of August, two thousand twenty five" 
```
- Расширение `Date#to_words`, добавлена возможность преобразовывать объекты Date и DateTime
```ruby
Date.new(2025, 8, 21).to_words(:ru)
# => "двадцать первого августа две тысячи двадцать пятого года"

Date.new(2025, 8, 21).to_words(:en)
# => "the twenty-first of August, two thousand twenty-five"
```
- Поддержка параметра `format: :nominative`, можно получать даты в именительном падеже.
```ruby
Date.new(2025, 8, 21).to_words(:ru, format: :nominative)
# => "двадцать первое августа две тысячи двадцать пятый год"

"19.07.2012".to_words(:ru, format: :nominative)
# => "девятнадцатое июля две тысячи двенадцатый год"
```

## [0.1.3] – 2025-08-20
### Added
- Параметр **`word_case:`** для методов `to_words`, `to_currency` со значениями:
    - `:upper`, `:capitalize`, `:title`, `:downcase`.
- В английской локали:
    - Поддержка опции **`style: :decimal`**, которая выводит дробную часть через `point` по-цифровому (например: `"twelve point one two"`).
    - Улучшена поддержка стиля **`:fraction`** — дроби преобразуются в слова с корректными окончаниями (`"tenths"`, `"hundredths"` и т.д.).
- Улучшена читаемость кода:
    - Унифицированные имена переменных (`major_value`, `minor_value`).
    - Вынес функционал `apply_case` для управления регистром.

###  Examples after 0.1.3

```ruby
10.1.to_words(locale: :ru, word_case: :capitalize)
# => "Десять целых одна десятая"

5.5.to_words(locale: :en, style: :fraction) # По умолчанию: style = fraction
# => "five and five tenths"

123.01.to_words(:en, style: :decimal, word_case: :upper)
# => "ONE HUNDRED TWENTY THREE POINT ZERO ONE" 

99.99.to_currency(locale: :ru, word_case: :upper)
# => "ДЕВЯНОСТО ДЕВЯТЬ РУБЛЕЙ ДЕВЯНОСТО ДЕВЯТЬ КОПЕЕК"

42.to_words(locale: :en, word_case: :title)
# => "Forty Two"

76.03.to_words(word_case: :downcase) # По умолчанию: word_case = downcase
"семьдесят шесть целых три сотые"
```

## [0.1.2] - 2025-08-19
### Fixed
- Исправлена ошибка с локалью `no` → заменена на корректную `nb` (Norwegian Bokmål).

---

## [0.1.1] - 2025-08-18
### Added
- Добавлены переводы для новых языков (Swahili, Punjabi и др.).
- В README.md добавлена Markdown-таблица языков с ISO-кодами и валютами.

### Fixed
- Исправлены ошибки в конфигурации валют для некоторых локалей.

---

## [0.1.0] - 2025-08-17
### Added
- Первая публичная версия гема `num2words`.
- Поддержка перевода чисел в слова для нескольких языков.
- Поддержка валют (RUB, USD, EUR и др.).
