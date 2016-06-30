class Code
  PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow,
    "O" => :orange,
    "P" => :purple
  }

  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end
  
  def self.parse(input)
    pegs = input.upcase.split("").each do |peg|
      raise "Invalid color entered!" unless PEGS.has_key?(peg)
    end
    Code.new(pegs)
  end
  
  def self.random
    pegs = []
    4.times { pegs << PEGS.keys.sample }
    Code.new(pegs)
  end
  
  def [](peg)
    pegs[peg]
  end
  
  def exact_matches(code)
    exact_match = 0
    code.pegs.each_index do |peg|
      exact_match += 1 if self.pegs[peg] == code.pegs[peg]
    end
    exact_match
  end
  
  def near_matches(code)
    near_match = 0
    code.pegs.each do |peg|
      if self.pegs.include?(peg)
        next if code.pegs.index(peg) == code.pegs.rindex(peg)
        near_match += 1 unless self.pegs.index(peg) == code.pegs.index(peg)
      end
    end
    near_match
  end
  
  def ==(code)
    return false unless code.is_a?(Code)
    return false unless self.exact_matches(code) == 4
    return true
  end
end


class Game
  attr_reader :secret_code
  
  def initialize(secret_code = nil)
    secret_code.nil? ? @secret_code = Code.random : @secret_code = secret_code
    @current_guess = nil
    @guesses = 0
  end
  
  def get_guess
    puts "Please enter a guess."
    if __FILE__ == $PROGRAM_NAME
      guess = gets.chomp
    else
      guess = $stdin.gets.chomp
    end
    puts "Your guess: #{guess.upcase}"
    @current_guess = Code.parse(guess)
    @guesses += 1
    @current_guess
  end
  
  def display_matches(code)
    puts "Number of exact matches: #{@secret_code.exact_matches(code)}"
    puts "Number of near matches: #{@secret_code.near_matches(code)}"
  end
  
  def win?
    return true if @current_guess == @secret_code && @guesses <= 10
    return false
  end
  
  def play
    puts "Welcome to Mastermind!"
    puts "The secret code has been set!"
    puts "Enter each guess as a series of 4 letters."
    puts "Each letter can be: 'R' for red, 'G' for green, 'B' for blue, 'Y' for yellow, 'O' for orange, or 'P' for purple."
    until @guesses == 10 || self.win?
      self.get_guess
      self.display_matches(@current_guess)
      puts (10 - @guesses).to_s + " guesses remaining!"
    end
    if self.win?
      puts "Congrats! You win!" if self.win?
    else
      puts "Sorry! Better luck next time!" if !self.win?
    end
  end
end

if __FILE__ == $PROGRAM_NAME
    new_game = Game.new
    new_game.play
end