current_path = File.dirname(__FILE__)

require_relative "viselitsa/game"
require_relative "viselitsa/result_printer"
require_relative "viselitsa/word_reader"

puts "Игра виселица. Версия 3. C чтением данных из файлов. (c) 2014 Mike Butlitsky\n\n"

printer = ResultPrinter.new

word_reader = WordReader.new

words_file_name = "#{current_path}/viselitsa/data/words.txt"
word_reader.read_from_file(words_file_name)

game = Game.new(word_reader.read_from_file(words_file_name))

while game.status == 0 do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)