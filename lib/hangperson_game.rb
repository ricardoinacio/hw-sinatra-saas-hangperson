class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  # Get a word from remote "random word" service
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError if letter == nil
    raise ArgumentError if letter.length == 0
    raise ArgumentError if (letter =~ /[^a-zA-Z]/) != nil
    letter.downcase!
    unless @guesses.include? letter or @wrong_guesses.include? letter
      guesses_mark = (@word.include? letter) ? @guesses : @wrong_guesses
      guesses_mark << letter
      return true
    else
      return false
    end
  end

  def word_with_guesses
    return @word.gsub(/[^#{@guesses}]/, "-") if @guesses.length > 0
    return "-" * @word.length
  end

  def check_win_or_lose
    return :win if word_with_guesses == @word
    return :lose if @wrong_guesses.length >= 7
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
