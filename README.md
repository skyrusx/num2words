# num2words [![Gem Version](https://badge.fury.io/rb/num2words.svg)](https://badge.fury.io/rb/num2words)

📦 **num2words** — Ruby-гем для преобразования чисел в строковое представление (прописью).

---

## ✨ Основные возможности

- Поддержка **чисел, времени, дат и валют**:
  - `Integer` -> `123.to_words(:ru)` -> `"сто двадцать три"`
  - `Float` -> `12.5.to_words(:en)` -> `"twelve and five tenths"`
  - `Time / DateTime` -> `"2024-08-21 14:35:42".to_words(:ru, :time)` -> `"четырнадцать часов тридцать пять минут сорок две секунды"`
  - `Float.to_currency` -> `12.5.to_currency(:ru)` -> `"двенадцать рублей пятьдесят копеек"`
- Кастомизация вывода:
  - Краткая форма (`short: true`) -> `"четырнадцать часов тридцать пять минут"`
  - Форматы времени (`:hours_only`, `:hours_minutes`, `:hours_minutes_seconds`)
  - Выбор локали: `:ru`, `:en` (из коробки), легко расширить YAML-файлами
- Расширение **Integer**, **Float**, **Date**, **Time**, **DateTime** удобными методами.
- Локали инициализируются только при обращении к ним (`lazy loading`) через `lib/num2words/locales.rb`.
- Унифицированный `Converter`, делегирующий работу нужной локали.
- Настраиваемые правила разрядов чисел и валют через I18n YAML.


---

## 📦 Установка

Добавьте в `Gemfile`:

```ruby
gem "num2words"
```

Или установите напрямую:

```bash
gem install num2words
```

---

## 🚀 Быстрый старт

```ruby
require "num2words"
```

### 🔢 Числа
```ruby
# Integer
123.to_words(:ru)          # => "сто двадцать три"
123.to_words(:en)          # => "one hundred twenty three"

# Float
45.67.to_words(:ru)               # => "сорок пять целых шестьдесят семь сотых"
"45,67".to_words(:ru)             # => "сорок пять целых шестьдесят семь сотых"
45.67.to_words(:ru, joiner: :and) # => "сорок пять и шестьдесят семь сотых"
45.67.to_words(:en)               # => "forty five and sixty seven hundredths"
```

### 💰 Валюта
```ruby
21.05.to_currency(:ru)     # => "двадцать один рубль пять копеек"
"21,05".to_currency(:ru)   # => "двадцать один рубль пять копеек"
Num2words.to_currency(BigDecimal("21.05"), :ru) # => "двадцать один рубль пять копеек"
1.to_currency(:ru, minor: :nonzero) # => "один рубль"
1.25.to_currency(:ru, minor: :never) # => "один рубль"
12.5.to_currency(:en)      # => "twelve dollars fifty cents"
```

### 📅 Дата
```ruby
"2024-08-21".to_words(:ru, :date)
# => "двадцать первое августа две тысячи двадцать четвёртого года"

"2024-08-21".to_words(:ru, :date, date_case: :genitive)
# => "двадцать первого августа две тысячи двадцать четвёртого года"

"2024-08-21".to_words(:en, :date)
# => "the twenty-first of August, two thousand twenty four"
```

### ⏰ Время
```ruby
"14:35:42".to_words(:ru, :time)
# => "четырнадцать часов тридцать пять минут сорок две секунды"

"14:35:42".to_words(:ru, :time, short: true) # или короткая запись: "14:35:42".to_words(:ru, :time, true)
# => "четырнадцать часов тридцать пять минут"

"14:35:42".to_words(:en, :time)
# => "fourteen hours thirty five minutes forty two seconds"
```

### 🕓 Дата и время

```ruby
"2024-08-21 14:35:42".to_words(:ru)
# =>  "двадцать первое августа две тысячи двадцать четвёртого года, четырнадцать часов тридцать пять минут сорок две секунды"

"2024-08-21 14:35:42".to_words(:ru, date_case: :genitive)
# =>  "двадцать первого августа две тысячи двадцать четвёртого года, четырнадцать часов тридцать пять минут сорок две секунды"

"2024-08-21 14:35:42".to_words(:en)
# => "the twenty-first of August, two thousand twenty four at fourteen hours thirty five minutes forty two seconds" 
```

### ⚙️ Опции

- `locale: :ru | :en` — язык (по умолчанию берётся I18n.locale или :ru).
- `:date, :time, :datetime` — формат преобразования для строк.
- `short: true` — краткая форма для даты/времени.
- `joiner: :and` — разговорный соединитель для дробей: `"ноль и пять десятых"` вместо `"ноль целых пять десятых"`.
- `date_case: :genitive` — родительный падеж дня для дат в контексте “когда?”.
- `Num2words.to_words(number, locale: :en)` — универсальный способ вызова без расширения базовых классов.
- `Num2words.to_currency(number)` — преобразование число в валюту.

### Консоль 💻

Num2words поддерживает интерактивную консоль для быстрого тестирования.  
Это удобно при работе с разными числами и языками.

#### Запуск консоли из репозитория

```bash
bin/console
```

#### Запуск консоли после установки гема

```bash
num2words-console
```

После запуска появится приветственное сообщение:

```bash
Добро пожаловать в консоль num2words!
Можете использовать: Num2words.to_words(2025)
-------------------------------------------------------------
```

👉 Это позволяет проверять работу гема без написания отдельных скриптов.

---

## 🌍 Доступные локали (из коробки)

| Язык          | ISO-код | Валюта      | Файл   |
|---------------|---------|-------------|--------|
| Английский    | en      | USD ($)     | en.yml |
| Русский       | ru      | RUB (₽)     | ru.yml |
| Китайский     | zh      | CNY (¥)     | zh.yml |
| Испанский     | es      | EUR (€)     | es.yml |
| Французский   | fr      | EUR (€)     | fr.yml |
| Немецкий      | de      | EUR (€)     | de.yml |
| Итальянский   | it      | EUR (€)     | it.yml |
| Португальский | pt      | EUR (€)     | pt.yml |
| Арабский      | ar      | SAR (﷼)     | ar.yml |
| Хинди         | hi      | INR (₹)     | hi.yml |
| Японский      | ja      | JPY (¥)     | ja.yml |
| Корейский     | ko      | KRW (₩)     | ko.yml |
| Турецкий      | tr      | TRY (₺)     | tr.yml |
| Нидерландский | nl      | EUR (€)     | nl.yml |
| Польский      | pl      | PLN (zł)    | pl.yml |
| Украинский    | uk      | UAH (₴)     | uk.yml |
| Чешский       | cs      | CZK (Kč)    | cs.yml |
| Румынский     | ro      | RON (lei)   | ro.yml |
| Болгарский    | bg      | BGN (лв)    | bg.yml |
| Белорусский   | be      | BYN (Br)    | be.yml |
| Казахский     | kz      | KZT (₸)     | kz.yml |
| Греческий     | el      | EUR (€)     | el.yml |
| Иврит         | he      | ILS (₪)     | he.yml |
| Шведский      | sv      | SEK (kr)    | sv.yml |
| Норвежский    | nb      | NOK (kr)    | nb.yml |
| Датский       | da      | DKK (kr)    | da.yml |
| Финский       | fi      | EUR (€)     | fi.yml |
| Венгерский    | hu      | HUF (Ft)    | hu.yml |
| Тайский       | th      | THB (฿)     | th.yml |
| Вьетнамский   | vi      | VND (₫)     | vi.yml |
| Индонезийский | id      | IDR (Rp)    | id.yml |
| Персидский    | fa      | IRR (﷼)     | fa.yml |
| Сербский      | sr      | RSD (дин)   | sr.yml |
| Хорватский    | hr      | EUR (€)     | hr.yml |
| Словацкий     | sk      | EUR (€)     | sk.yml |
| Словенский    | sl      | EUR (€)     | sl.yml |
| Литовский     | lt      | EUR (€)     | lt.yml |
| Латышский     | lv      | EUR (€)     | lv.yml |
| Эстонский     | et      | EUR (€)     | et.yml |
| Малайский     | ms      | MYR (RM)    | ms.yml |
| Бенгальский   | bn      | BDT (৳)     | bn.yml |
| Урду          | ur      | PKR (₨)     | ur.yml |
| Тамильский    | ta      | INR (₹)     | ta.yml |
| Телугу        | te      | INR (₹)     | te.yml |
| Малаялам      | ml      | INR (₹)     | ml.yml |
| Каннада       | kn      | INR (₹)     | kn.yml |
| Маратхи       | mr      | INR (₹)     | mr.yml |
| Гуджарати     | gu      | INR (₹)     | gu.yml |
| Панджаби      | pa      | INR (₹)     | pa.yml |
| Суахили       | sw      | KES (Sh)    | sw.yml |

Можно легко добавить новые:

- YAML-файл: `config/locales/xx.yml`
- Обёртка: `lib/num2words/locales/xx.rb`

### 🌍 Поддержка локалей (ru / en)

| Возможность                   | ru        | en         |
| ----------------------------- | --------- | ---------- |
| 🔢 Числа (Integer)            | ✔         | ✔          |
| 🔢 Числа (Float)              | ✔         | ✔          |
| 💰 Валюта                     | ✔ (рубли) | ✔ (rubles) |
| 💰 Валюта (short)             | ✖         | ✖          |
| 💱 Выбор валюты (USD/EUR/…)   | ✖         | ✖          |
| 📅 Дата                       | ✔         | ✔          |
| ⏰ Время                      | ✔         | ✔          |
| 🕓 Дата и время               | ✔         | ✔          |
| 📝 Краткая форма даты/времени | ✔         | ✔          |

---

## 🧪 Тестирование

```bash
bundle exec rspec
```

## 📌 Roadmap

- [x] 🇬🇧 Поддержка английского языка
- [x] 🔠 Опция выбора регистра (строчные/Прописные)
- [x] ⏰ Краткая форма даты/времени
- [ ] 💵 Поддержка других валют (USD, EUR и т.д)
- [ ] 💰 Краткая форма валюты

---

## 📜 Лицензия

[MIT](LICENSE)
