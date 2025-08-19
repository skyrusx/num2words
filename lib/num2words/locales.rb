# frozen_string_literal: true

module Num2words
  module Locales
    @registry = {}

    class << self
      # Регистрация новой локали
      def register(locale, mod)
        @registry[locale.to_sym] = mod
      end

      # Доступ по синтаксису Locales[:ru]
      def [](locale)
        locale = locale.to_sym
        @registry[locale] || autoload_locale(locale)
      end

      private

      # Автоматическая подгрузка файла locales/xx.rb
      def autoload_locale(locale)
        locale_path = File.join(__dir__, "locales", "#{locale}.rb")
        if File.exist?(locale_path)
          require locale_path
          @registry[locale] || raise("Locale #{locale} not registered")
        else
          raise ArgumentError, "Locale file not found: #{locale_path}"
        end
      end
    end
  end
end
