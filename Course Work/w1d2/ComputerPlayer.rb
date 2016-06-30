require './Board.rb'

class ComputerPlayer
  attr_reader :board, :current_guess_card, :previous_guess_card

  def initialize
    @known_cards = Hash.new {|h,k| h[k] = []}
    @board = Board.new
    @previous_guess = nil
    @current_guess = nil
    @current_guess_card = nil
    @previous_guess_card = nil
  end

  def guess
    known_match?
    if @previous_guess.nil?
      @previous_guess = rand(0..15)
      until !@known_cards.values.flatten.include?(@previous_guess)
        @previous_guess = rand(0..15)
      end
    end
    @previous_guess_card = @board.grid[@previous_guess][0]
    @known_cards[@previous_guess_card.face_value] << @previous_guess
    @previous_guess_card.reveal
    puts @known_cards
    puts "Computer is guessing #{@previous_guess}"
    @previous_guess = nil
    if @known_cards[@previous_guess_card.face_value].length == 2
      @current_guess = @known_cards[@previous_guess_card.face_value][0]
    else
      @current_guess = rand(0..15)
      until !@known_cards.values.flatten.include?(@current_guess)
        @current_guess = rand(0..15)
      end
    end
    @current_guess_card = @board.grid[@current_guess][0]
    @current_guess_card.reveal
    puts "Computer is guessing #{@current_guess}"
    @current_guess = nil
  end

  def known_match?
    @known_cards.each do |k,v|
      if v.length > 1 && !@board.grid[v[0]][0].orientation
        @previous_guess = v[0]
        @current_guess = v[1]
      end
    end
  end
end
