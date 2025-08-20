# num2words [![Gem Version](https://badge.fury.io/rb/num2words.svg)](https://badge.fury.io/rb/num2words)

📦 **num2words** — Ruby-гем для преобразования чисел в строковое представление (прописью).

---

## ✨ Основные возможности

- Поддержка **современных локалей** (включая русский и английский) через YAML-файлы `config/locales/*.yml`.
- Удобные методы:
    - `Num2words.to_words(123)`
    - `Num2words.to_currency(12.34)`
- Расширение `Integer` и `Float`:
    - `123.to_words(:en)`
    - `12.5.to_currency(locale: :ru)`
- Короткая запись локали (символом): `123.to_words(:en)`
- Lazy‑загрузка локалей (`lib/num2words/locales.rb`).
- Унифицированный `Converter`, делегирующий логику нужной локали.
- Разряды чисел и валюты настраиваются через I18n YAML.

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

# По умолчанию используется I18n.locale или fallback :ru
Num2words.to_words(21)          # => "двадцать один"
Num2words.to_currency(21.05)    # => "двадцать один рубль пять копеек"

# Short-style:
123.to_words                    # "сто двадцать три"
123.to_words(:en)               # "one hundred twenty three"
123.to_words(locale: :en)       # "one hundred twenty three"

# Валюта:
12.5.to_currency(:en)           # "twelve rubles fifty kopeks"
12.5.to_currency(locale: :ru)   # "двенадцать рублей пятьдесят копеек"
```

### Консоль 💻

Num2words поддерживает интерактивную консоль для быстрого тестирования.  
Это удобно при работе с разными числами и языками.

#### Запуск консоли

```bash
bin/console
```

После запуска появится приветственное сообщение:

```bash
👋 Добро пожаловать в консоль num2words!
Попробуйте: Num2words.to_words(2025)
-----------------------------------------------------
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

---

## 🧪 Тестирование

```bash
bundle exec rspec
```

## 📌 Roadmap

- [x] 🇬🇧 Поддержка английского языка
- [ ] 💵 Поддержка других валют (USD, EUR)
- [ ] 🔠 Опция выбора регистра (строчные/Прописные)

---

## 📜 Лицензия

[MIT](LICENSE)
