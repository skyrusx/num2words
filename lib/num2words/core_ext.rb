# frozen_string_literal: true

class Integer
  def to_words(feminine: false)
    Num2words::Converter.to_words(self, feminine: feminine)
  end

  def to_currency
    Num2words::Converter.to_currency(self)
  end
end

class Float
  def to_currency
    Num2words::Converter.to_currency(self)
  end
end
