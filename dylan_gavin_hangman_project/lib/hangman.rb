class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
      @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index { |val, i| indices << i if val == char }
    indices
  end

  def fill_indices(char, idx_array)
    idx_array.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    end
    if self.get_matching_indices(char).empty?
      @remaining_incorrect_guesses -= 1
      @attempted_chars << char
      return true
    else
      self.fill_indices(char, get_matching_indices(char))
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    input = gets.chomp
    return self.try_guess(input)
  end

  def win?
    if @guess_word.join("") == @secret_word
       puts "WIN"
       return true
    else
      return false
    end
  end

  def lose? 
    if @remaining_incorrect_guesses == 0 
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    else
      return false
    end
  end


end
