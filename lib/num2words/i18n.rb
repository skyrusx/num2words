# frozen_string_literal: true

require "i18n"

module Num2words
  module I18nSetup
    def self.load!
      locales_path = File.expand_path("../../config/locales/*.yml", __dir__)
      files = Dir[locales_path]

      if files.empty?
        raise "Num2words: не найдены файлы локалей в #{locales_path}"
      end

      I18n.load_path += files
      I18n.available_locales = [:ru, :en]
      I18n.default_locale = :ru
      I18n.enforce_available_locales = true

      # Проверяем, что ключи реально доступны
      %i[ru en].each do |loc|
        unless I18n.exists?("num2words.ones_masc", locale: loc)
          raise "Num2words: отсутствуют ключи для локали #{loc} в locales/#{loc}.yml"
        end
      end
    end
  end
end

Num2words::I18nSetup.load!
