require './Board.rb'

class HumanPlayer

  attr_reader :board, :previous_guess_card, :current_guess_card

  def initialize(name)
    @name = name
    @board = Board.new
    @current_guess = nil
    @previous_guess = nil
    @current_guess_card = nil
    @previous_guess_card = nil
  end

  def guess
    puts "Which card would you like to flip? (0-15)"
    @previous_guess = gets.chomp.to_i
    @previous_guess_card = @board.grid[@previous_guess][0]
    until !@previous_guess_card.orientation
      puts "You already guessed that card, dumbass! Guess again!"
      @previous_guess = gets.chomp.to_i
      @previous_guess_card = @board.grid[@previous_guess][0]
    end
    @previous_guess_card.reveal
    @board.render
    puts "Which second card would you like to flip? (0-15)"
    @current_guess = gets.chomp.to_i
    @current_guess_card = @board.grid[@current_guess][0]
    until !@current_guess_card.orientation
      puts "You already guessed that card, dumbass! Guess again!"
      @current_guess = gets.chomp.to_i
      @current_guess_card = @board.grid[@current_guess][0]
    end
    @current_guess_card.reveal
    @board.render
  end
end
