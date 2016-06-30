class ComputerPlayer
    attr_reader :name, :board
    attr_accessor :mark
    
    def initialize(name)
        @name = name
        @mark = nil
    end
    
    def display(board)
        @board = board
    end
    
    def get_move
        squares = @board.grid
        row, col = nil, nil
        i = 0
        j = 0
        pos_moves = []
        while i < squares.length
            while j < squares[0].length
                pos_moves << [i, j] if @board.empty?([i, j])
                j += 1
            end
            j = 0
            i += 1
        end
        pos_moves.each do |move|
            squares[move[0]][move[1]] = @mark
            if @board.winner.nil?
                squares[move[0]][move[1]] = nil
            else
                squares[move[0]][move[1]] = nil
                puts "The computer has made it's move!"
                return move
            end
        end
        puts "The computer has made it's move!"
        pos_moves.sample
    end
end
