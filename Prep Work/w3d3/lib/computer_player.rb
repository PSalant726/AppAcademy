class ComputerPlayer
    attr_reader :name, :ship_locations
    attr_accessor :board, :hits, :moves_made, :ship_hits
    
    def initialize
        @name = "Computer"
        @ship_locations = {}
        @hits = []
        @moves_made = []
        @ship_hits = []
    end
    
    def define_board(board)
        @board = board
    end
    
    def display(board)
        self.define_board(board)
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
    
    def get_play
        ships_remaining = 5
        move = @board.random_position
        if !@hits.length.nil?
            until !@moves_made.include?(move)
                # next move within 1 space of a known hit
                move = @hits.sample
                changes = [:+, :-]
                shifts = [0, 1]
                x_coord = move[0].send(changes.sample, shifts.sample)
                y_coord = move[1].send(changes.sample, shifts.sample)
                move = [x_coord,y_coord]
            end
        else
            until !@moves_made.include?(move)
                move = @board.random_position
            end
        end
        move
    end
    
    def setup(player, board)
        puts "The computer is setting it's board..."
        self.define_board(board)
        ships_placed = []
        while ships_placed.length < 5
            ship_number = [1,2,3,4,5].sample
            if !ships_placed.include?(ship_number)
                ship_start = @board.random_position
                ship_orient = ["H","V"].sample
                ship_info = Ships.place_ship(ship_number, ship_start, ship_orient, player)
                unless ship_info[0]
                    ships_placed << ship_number
                    ship_info[1].each do |space|
                        @board[*space] = :s
                    end
                    @ship_locations[ship_number] = ship_info[1]
                end
            end
        end
    end
end