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

class String
  def to_words(*args, **opts)
    Num2words::Converter.to_words(self, *args, **opts)
  end
end

class Date
  def to_words(*args, **opts)
    Num2words::Converter.to_words(self.strftime("%d.%m.%Y"), *args, **opts)
  end
end

class Time
  def to_words(*args, **opts)
    Num2words::Converter.to_words(self.strftime("%H:%M:%S"), *args, **opts)
  end
end

class DateTime
  def to_words(*args, **opts)
    Num2words::Converter.to_words(self.strftime("%d.%m.%Y %H:%M:%S"), *args, **opts)
  end
end
