require './Board.rb'
require './Card.rb'
require './HumanPlayer.rb'
require './ComputerPlayer.rb'

class Game

  # attr_reader :board

  def initialize(player)
    @player = player
    @turns_played = 0

  end

  def over?
    @player.board.won?
  end

  def play
    puts "Let's play a memory game!"
    @player.board.populate
    until over? || @turns_played == 20
      @player.guess
      unless match?
        puts "Sorry! Try again!"
        @player.previous_guess_card.hide
        @player.current_guess_card.hide
      else
        puts "It's a match!"
      end
      sleep(2)
      system("clear")
      @player.board.render
      @turns_played += 1
    end
    if over?
      puts "Congrats! You win!"
    else
      puts "Game over! You reached the max number of turns!"
    end
  end

  def match?
    @player.previous_guess_card == @player.current_guess_card
  end
end

if __FILE__ == $PROGRAM_NAME
  player = ComputerPlayer.new
  game = Game.new(player)
  game.play
end
