# frozen_string_literal: true

module Num2words
  module Console
    module_function

    def start
      puts "Добро пожаловать в консоль num2words!"
      puts "Можете использовать: Num2words.to_words(#{Time.now.year})"
      puts "-------------------------------------------------------------"

      require "irb"
      IRB.start(__FILE__)
    end
  end
end
