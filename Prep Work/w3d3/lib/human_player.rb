class HumanPlayer
    attr_reader :name, :ship_locations
    attr_accessor :board, :hits, :moves_made, :ship_hits
    
    def initialize(name)
        @name = name
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
    
    def setup(player, board)
        puts "#{@name}, let's set up your board! Place all 5 of your ships."
        ships_placed = []
        self.define_board(board)
        while ships_placed.length < 5
            self.display(@board) if ships_placed.length > 0
            puts "Which ship would you like to place? Enter a number 1 through 5"
            puts "1: Aircraft Carrier (5 spaces)\n2: Battleship (4 spaces)\n3: Submarine (3 spaces)\n4: Destroyer (3 spaces)\n5: Patrol Boat (2 spaces)"
            ship_number = gets.chomp.to_i
            if Ships::SHIP_NAMES.has_key?(ship_number)
                if ships_placed.include?(ship_number)
                    puts "You've already placed the #{Ships::SHIP_NAMES[ship_number]}!"
                else
                    puts "Ok! Where would you like to place the #{Ships::SHIP_NAMES[ship_number]}?\nEnter the starting position as 'row', 'column'."
                    ship_start = gets.chomp.split(", ").map! { |num| num.to_i }
                    puts "Enter 'H' to place the ship horizontally, or 'V' to place it vertically."
                    ship_orient = gets.chomp.upcase
                    ship_info = Ships.place_ship(ship_number, ship_start, ship_orient, player)
                    if ship_info[0]
                        puts "You can't place your ship there with that orientation!"
                        puts "Please select a different space or orientation."
                    else
                        ships_placed << ship_number
                        ship_info[1].each do |space|
                            @board[*space] = :s
                        end
                        puts "Ok! You placed the #{Ships::SHIP_NAMES[ship_number]}!"
                        @ship_locations[ship_number] = ship_info[1]
                    end
                end
                puts "#{5 - ships_placed.length} ships remaining!" unless ships_placed.length == 5
            else
                puts "That's not a valid ship number! Please try again."
            end
        end
        puts "All ships have been placed. Would you like to display your board on the screen? Reply 'Y' or 'N'."
        display_pref = gets.chomp.upcase
        self.display(@board) if display_pref == "Y"
    end
    
    def get_play
        puts "#{@name}, where would you like to attack?\nEnter your attack as 'row', 'column'."
        play = gets.chomp.split(", ")
        play.map! { |num| num.to_i }
        @moves_made << play
        play
    end
end