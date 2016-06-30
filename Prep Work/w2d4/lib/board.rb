class Board
    attr_reader :cols
    attr_accessor :winner, :grid

    def initialize(grid = nil)
        grid.nil? ? @grid = Array.new(3) { Array.new(3) } : @grid = grid
        @cols = Array.new(3) { Array.new(3) }
    end

    def [](row, col)
        @grid[row][col]
    end

    def []=(row, col, mark)
        @grid[row][col] = mark
    end

    def empty?(pos)
        self[*pos].nil?
    end

    def place_mark(pos, mark)
        if self.empty?(pos)
            self[*pos] = mark
        else
            raise "That square is taken!"
        end
    end

    def update_cols
        i = 0
        j = 0
        while i < @grid[0].length
            while j < @grid.length
                @cols[i][j] = @grid[j][i]
                j += 1
            end
            j = 0
            i += 1
        end
    end

    def winner
        # Check each row
        self.grid.each do |row|
            return row[0] if row.uniq.length == 1 && !row[0].nil?
        end
        # Check each colum
        self.update_cols
        self.cols.each do |col|
            return col[0] if col.uniq.length == 1 && !col[0].nil?
        end
        # Check diagonals
        if self[0, 0] == self[1, 1] && self[0, 0] == self[2, 2]
            return self[0, 0]
        elsif self[0, 2] == self[1, 1] && self[0, 2] == self[2, 0]
            return self[0, 2]
        end
        return nil
    end

    def over?
        return true if !self.winner.nil?
        marks = []
        i = 0
        j = 0
        while i < self.grid[0].length
            while j < self.grid.length
                marks << @grid[j][i]
                j += 1
            end
            j = 0
            i += 1
        end
        marks.include?(nil) ? false : true
    end
end
