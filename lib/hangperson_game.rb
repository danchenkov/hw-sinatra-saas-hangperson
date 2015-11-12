class HangpersonGame

  attr_reader :word, :guesses, :wrong_guesses, :word_with_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-'*word.length
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(guess)
    # raise ArgumentError if guess.nil? or guess.class != String or guess !~ /[A-Za-z]/
    return :error if guess.nil? or guess.class != String or guess !~ /[A-Za-z]/
  	guess.downcase!

    match_indexes = @word.split('').each_index.select{|i| @word[i] == guess}

    if (match_indexes.length == 0)
    	@wrong_guesses.include?(guess)  ? :wrong_guess : @wrong_guesses[@wrong_guesses.length] = guess
    else
    	match_indexes.each { |i| @word_with_guesses[i] = guess }
    	@guesses.include?(guess) ? :wrong_guess : @guesses[@guesses.length] = guess
    end
  end

  def check_win_or_lose
  	return :lose if @wrong_guesses.length >= 7
  	return :win if @word_with_guesses.index('-').nil?
  	:play
  end
end

def guess_several_letters(game, word)
	word.each do |g|
		game.guess(g)
	end
end

