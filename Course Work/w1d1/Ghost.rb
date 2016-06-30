class Game
  attr_accessor :fragment, :current_guess, :dictionary

  def initialize(player1, player2)
    @dictionary = Hash.new
    File.foreach("dictionary.txt") do |line|
        @dictionary[line.chomp] = true
    end
    @player1 = player1
    @player2 = player2
    @fragment = ""
    @current_player = @player1
    @previous_player = @player2
  end

  def play_round
    puts "It is #{@current_player.name}'s turn!"
    @current_guess = @current_player.guess
    until check_guess?
      @current_guess = @current_player.guess
    end
    @fragment += @current_guess
    puts "The current word is: '#{@fragment}'"
    switch_player
  end

  def check_guess?
    valid = false
    string_to_check = @fragment + @current_guess
    @dictionary.each_key do |word|
      if word.start_with?(string_to_check)
        valid = true
        break
      end
    end

    if valid
      return true
    else
      @current_player.alert_invalid_guess
      return false
    end
  end

  def switch_player
    @previous_player,@current_player = @current_player,@previous_player
  end

  def round_over?
    return true if @dictionary.has_key?(@fragment)
    false
  end

  def game_over?
    if @player1.score.length == 5 || @player2.score.length == 5
      
  end

  def play
    puts "Welcome to Ghost! #{@current_player.name} goes first!"
    until game_over?
      until round_over?
        play_round
      end
      puts "#{@current_player.name} wins the round!"
    end


  end

end

class HumanPlayer
  attr_reader  :name, :score

  def initialize(name)
    @name = name
    @score = ""
  end

  def guess
    puts "What letter would you like to guess?"
    gets.chomp
  end

  def alert_invalid_guess
    puts "That guess is invalid! Guess again!"
  end



end

if __FILE__ == $PROGRAM_NAME
  rb = HumanPlayer.new("RB")
  phil = HumanPlayer.new("Phil")
  #computer = ComputerPlayer.new
  mygame = Game.new(rb,phil)
  #p mygame.dictionary
  mygame.play

end
