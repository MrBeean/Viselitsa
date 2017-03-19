current_path = File.dirname(__FILE__)

require_relative "viselitsa/game"
require_relative "viselitsa/result_printer"
require_relative "viselitsa/word_reader"

VERSION = "Игра виселица. Версия 5. (c) Хороший программист\n\n"

printer = ResultPrinter.new

word_reader = WordReader.new

words_file_name = "#{current_path}/viselitsa/data/words.txt"
word = word_reader.read_from_file(words_file_name)

game = Game.new(word)
game.version = VERSION

while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

printer.print_status(game)