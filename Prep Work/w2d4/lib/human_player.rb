class HumanPlayer
    attr_reader :name
    attr_accessor :mark
    
    def initialize(name)
        @name = name
        @mark = nil
    end

    def display(board)
        @board = board
        i = 0
        j = 0
        display_string = ""
        while i < @board.grid.length
            while j < @board.grid[0].length
                space = @board.grid[i][j]
                space.nil? ? space = " " : space = @board.grid[i][j]
                display_string += "[#{space}]" unless j == @board.grid.length - 1
                display_string += "[#{space}]\n" if j == @board.grid.length - 1
                j += 1
            end
            j = 0
            i += 1
        end
        puts display_string
    end
    
    def get_move
        puts "It's #{@name}'s move! Where would you like to place your mark? Type your move as 'row, column'."
        move = gets.chomp.split(", ")
        puts "Move made!"
        move.map! { |num| num.to_i }
    end
end