class Board
    attr_reader :grid
    
    def initialize(grid=self.class.default_grid)
        @grid = grid
    end
  
    def self.default_grid
        Array.new(10) {Array.new(10)}
    end
    
    def [](*args)
        if args.size == 1 
            row, col = args[0][0,2]
        else
            row, col = args[0, 2]
        end
        @grid[row][col]
    end

    def []=(*pos, val)
        x, y = pos
        @grid[x][y] = val
    end

    def count
        ships = @grid.flatten.select { |mark| mark == :s }
        ships.length
    end
    
    def empty?(pos = nil)
        if pos.nil?
            self.count == 0
        else
            self[*pos].nil?
        end
    end
    
    def full?
        !@grid.flatten.include?(nil)
    end
   
    def random_position
        [rand(@grid.length),rand(@grid.length)]
    end

    def place_random_ship
        raise "The board is full!" if self.full?
        pos = random_position
        pos = random_position until empty?(pos)
        self[*pos] = :s
    end

    def won?
        true if !@grid.flatten.include?(:s)
    end
end