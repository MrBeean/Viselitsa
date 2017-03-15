current_path = File.dirname(__FILE__)

require_relative "game"
require_relative "result_printer"
require_relative "word_reader"

puts "Игра виселица. Версия 3. C чтением данных из файлов. (c) 2014 Mike Butlitsky\n\n"

printer = ResultPrinter.new

word_reader = WordReader.new

words_file_name = "#{current_path}/data/words.txt"
word_reader.read_from_file(words_file_name)

game = Game.new(word_reader.read_from_file(words_file_name))

while game.status == 0 do
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)