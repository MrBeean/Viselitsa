class ResultPrinter
  def initialize
    @status_image = []

    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <=7 do
      file_name = current_path + "/image/#{counter}.txt"

      begin
        File.exist?(file_name)
        f = File.new(file_name, "r:UTF-8")
        @status_image << f.read
        f.close
      rescue SystemCallError
        @status_image << "\n [ изображение не найдено ] \n"
      end

      counter += 1
    end
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def print_status(game)
    cls
    puts game.version

    puts "\nСлово: #{get_word_for_print(game.letters, game.good_letters)}"

    puts "\nОшибки: #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    if game.lost?
      puts "\nВы проиграли :(\n"
      puts "Загаданное слово было: " + game.letters.join("")
    elsif game.won?
      puts "Поздравляем, вы выиграли!\n\n"
    else
      puts "У вас осталось ошибок: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, good_letters)
    result = ""

    letters.each do |letter|
      result += if good_letters.include?(letter)
                  letter + ' '
                else
                  '__ '
                end
    end

    result
  end

  def cls
    system("clear") || system("cls")
  end
end
