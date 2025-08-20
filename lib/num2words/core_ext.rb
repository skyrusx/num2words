# frozen_string_literal: true

class Integer
  def to_words(*args, **opts)
    Num2words::Converter.to_words(self, *args, **opts)
  end

  def to_currency(*args, **opts)
    Num2words::Converter.to_currency(self, *args, **opts)
  end
end

class Float
  def to_words(*args, **opts)
    Num2words::Converter.to_words(self, *args, **opts)
  end

  def to_currency(*args, **opts)
    Num2words::Converter.to_currency(self, *args, **opts)
  end
end
