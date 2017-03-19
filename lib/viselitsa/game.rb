require "unicode_utils/downcase"

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  attr_accessor :version

  MAX_ERRORS = 7
  LETTER_REGEXP = /й|ё|е|и/

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress
    # :in_progress — игра продолжается
    # :won — игра выиграна
    # :lost — игра проиграна
  end

  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Задано пустое слово, не о чем играть. Закрываемся."
    else
      slovo = slovo.encode("UTF-8")
    end

    down_case_ru(slovo).split('')
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def is_good?(letter)
    @letters.include?(letter) ||
      (letter.match(LETTER_REGEXP) && @letters.grep(LETTER_REGEXP))
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when "е" then letters << "ё"
    when "ё" then letters << "е"
    when "й" then letters << "и"
    when "и" then letters << "й"
    end
  end

  def next_step(letter)
    downcase_letter = down_case_ru(letter)

    return if @status == :lost || @status == :won

    return if repeated?(downcase_letter)


    if is_good?(downcase_letter)
      add_letter_to(@good_letters, downcase_letter)

      @status = :won if solved?
    else
      add_letter_to(@bad_letters, downcase_letter)

      @errors += 1

      @status = :lost if lost?
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"

    letter = ''

    letter = STDIN.gets.encode('UTF-8').chomp while letter == ''

    next_step(letter)
  end

  def down_case_ru(ru_string)
    UnicodeUtils.downcase(ru_string)
  end
end
