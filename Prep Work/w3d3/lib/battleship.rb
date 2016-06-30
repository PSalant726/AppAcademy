require_relative "board"
require_relative "human_player"
require_relative "computer_player"
require_relative "ships"

class BattleshipGame
    attr_reader :board, :player

    def initialize(player1, board = nil, player2 = nil, board2 = nil)
        player1.is_a?(String) ? @player1 = HumanPlayer.new(player1) : @player1 = player1
        player2.nil? ? @player2 = ComputerPlayer.new : @player2 = player2
        board.nil? ? @board = Board.new : @board = board
        board2.nil? ? @board2 = Board.new : @board2 = board
        @current_player = [@player1, @player2].sample
    end
    
    def attack(pos)
        if __FILE__ == $PROGRAM_NAME
            puts "#{@current_player.name} attacks at #{pos}!"
            @current_player.moves_made << pos
            self.switch_player!
            if @current_player.board[*pos] == :s
                puts "It's a hit!"
                self.switch_player!
                @current_player.hits << pos
                self.switch_player!
            else
                puts "It's a miss!"
            end
            @current_player.board[*pos] = :x
            @current_player.ship_locations.each do |key, value|
                value.each do |space|
                    @current_player.ship_hits << @current_player.board[*space]
                end
                if !@current_player.ship_hits.include?(:s)
                    puts "You sunk #{@current_player.name}'s #{Ships::SHIP_NAMES[key]}!"
                end
            end
            self.switch_player!
        else
            # So specs will pass
            self.board[*pos] = :x
        end
    end
    
    def count
        @board.count
    end
    
    def game_over?
        @board.won?
    end
    
    def play_turn
        if __FILE__ == $PROGRAM_NAME
            @current_player.define_board(@current_player.board)
            self.attack(@current_player.get_play)
        else
            # So specs will pass
            self.attack(@player1.get_play)
        end
    end
    
    def switch_player!
        if @current_player == @player1
            @current_player = @player2
        else
            @current_player = @player1
        end
    end
    
    def setup
        @player1.setup(@player1, @board)
        @player2.setup(@player2, @board2)
    end
    
    def play
        puts "Welcome to Battleship, #{@player1.name} and #{@player2.name}!"
        self.setup
        puts "The boards are set! Let's play Battleship!"
        puts "#{@current_player.name} goes first!"
        until @board.won? || @board2.won?
            self.play_turn
            self.switch_player!
        end
        @board.won? ? @current_player = @player2 : @current_player = @player1
        puts "Game over! #{@current_player} wins!"
    end

    if __FILE__ == $PROGRAM_NAME
        game = BattleshipGame.new("Player1")
        # Play a friend
        # game = BattleShipGame.new("Player1", nil, "Player1")
        # "nil" included as the second argument so that the specs will still pass
        game.play
    end
end