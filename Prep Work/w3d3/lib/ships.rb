class Ships
    SHIP_NAMES = {
        1 => "Aircraft Carrier",
        2 => "Battleship",
        3 => "Submarine",
        4 => "Destroyer",
        5 => "Patrol Boat"
    }
    
    SHIP_SIZES = {
        1 => 5,
        2 => 4,
        3 => 3,
        4 => 3,
        5 => 2
    }
    
    def initialize(ship_number)
        @ship_number = ship_number
        @ship_name = SHIP_NAMES[@ship_number]
        @ship_size = SHIP_SIZES[@ship_number]
    end
    
    def self.place_ship(ship_number, ship_start, ship_orient, player)
        if ship_orient == "H"
            ship_end = [ship_start[0], (ship_start[1] + Ships::SHIP_SIZES[ship_number].to_i - 1)]
            ship_spaces = [ship_start, ship_end]
            i = ship_start[1] + 1
            while i < ship_end[1]
                ship_spaces << [ship_start[0], i]
                i += 1
            end
            space_taken = false
            ship_spaces.each { |space| space_taken = true if !player.board[space].nil? || space[0] > player.board.grid.length || space[1] > player.board.grid[0].length - 1 }
            ship_info = [space_taken, ship_spaces]
        elsif ship_orient == "V"
            ship_end = [(ship_start[0] + Ships::SHIP_SIZES[ship_number].to_i - 1), ship_start[1].to_i]
            ship_spaces = [ship_start, ship_end]
            i = ship_start[0] + 1
            while i < ship_end[0]
                ship_spaces << [i, ship_start[1]]
                i += 1
            end
            space_taken = false
            ship_spaces.each { |space| space_taken = true if space[0] > player.board.grid.length - 1 || space[1] > player.board.grid[0].length }
            unless space_taken
                ship_spaces.each { |space| space_taken = true if !player.board[space].nil? }
            end
            ship_info = [space_taken, ship_spaces]
        else
            puts "I don't understand that orientation. Please try again."
        end
    end
end