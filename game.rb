require "unicode_utils/downcase"

class Game
  def initialize(slovo)
    @letters = get_letters(slovo)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = 0
  end

  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Задано пустое слово, не о чем играть. Закрываемся."
    else
      slovo = slovo.encode("UTF-8")
    end

    return down_case_ru(slovo).split("")
  end

  def status
    return @status
  end

  def next_step(bukva)
    downcase_bukva = down_case_ru(bukva)

    return if @status == -1 || @status == 1

    if @good_letters.include?(downcase_bukva) || @bad_letters.include?(downcase_bukva)
      return
    end

    letter_regexp = /й|ё|е|и/

    if @letters.include?(downcase_bukva) ||
       (downcase_bukva.match(letter_regexp) && @letters.grep(letter_regexp))

      @good_letters << downcase_bukva

      case downcase_bukva
      when "е"
        @good_letters << "ё"
      when "ё"
        @good_letters << "е"
      when "й"
        @good_letters << "и"
      when "и"
        @good_letters << "й"
      end

      @status = 1 if (@letters - @good_letters).empty?
    else
      @bad_letters << downcase_bukva

      @errors += 1

      @status = -1 if @errors >= 7
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ""
    while letter == "" || letter.size > 1 do
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

# ----------------------------------------------------------------------
  #Переопределяем метод upcase с помощью библиотеки unicode_utils/upcase
  def down_case_ru(ru_string)
    UnicodeUtils.downcase(ru_string)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
