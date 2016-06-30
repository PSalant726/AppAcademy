require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
    attr_accessor :current_player, :player_one, :player_two, :board

    def initialize(player_one, player_two=nil)
        @player_one = player_one
        if player_two.nil?
            @player_two = ComputerPlayer.new("Computer")
        else
            @player_two = player_two
        end
        @player_one.mark = :X
        @player_two.mark = :O
        @board = Board.new
        @current_player = @player_one
    end

    def play_turn
        @board.place_mark(@current_player.get_move, @current_player.mark)
        switch_players!
    end

    def switch_players!
        if @current_player == @player_one
            @current_player = @player_two
        else
            @current_player = @player_one
        end
    end

    def play
        puts "Welcome to Tic-Tac-Toe, #{@player_one.name} and #{@player_two.name}!"
        puts "Let's start a new game!"
        puts "#{@current_player.name} goes first!"
        until @board.over?
            @current_player.display(@board)
            play_turn
        end
        puts "Game over!"
        @player_one.display(@board)
        if @board.winner == :X
            puts "#{@player_one.name} wins!"
        elsif @board.winner == :O
            puts "#{@player_two.name} wins!"
        else
            puts "It's a tie!"
        end
    end

    if __FILE__ == $PROGRAM_NAME
        player_one = HumanPlayer.new("Player 1")
        player_two = HumanPlayer.new("Player 2")
        # Add player_two to the Game.new arguments to play with another human
        new_game = Game.new(player_one)
        # new_game = Game.new(player_one, player_two)
        new_game.play
    end
end
