class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def word_with_guesses()
    ret = ''
    @word.split('').each { |c|
      if @guesses.include?(c)
        ret+= c
      else
        ret+= '-'
      end
    }
    ret
  end

  def check_win_or_lose()
    win = true
    @word.split('').each { |c|
      if !@guesses.include?(c)
        win = false
      end
    }
    if win
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    end
    :play
  end


  def guess(c)
    if c == '' || c.nil? || (c=~/[a-zA-Z]+/).nil?
      raise ArgumentError.new()
      return
    end
    c = c.downcase
    if @guesses.include?(c) || @wrong_guesses.include?(c)
      return false
    elsif @word.downcase.include?(c)
      @guesses+=c
      return true

    else
      @wrong_guesses+=c
      true
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
