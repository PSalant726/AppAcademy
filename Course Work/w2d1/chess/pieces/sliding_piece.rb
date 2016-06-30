require_relative 'piece'

class SlidingPiece < Piece

  BISHOP_MOVES = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  ROOK_MOVES = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ]

  QUEEN_MOVES = BISHOP_MOVES.dup.concat(ROOK_MOVES.dup)

  def moves
    dirs = self.move_dirs
    pos_moves = []
    dirs.each do |dir|
      x_end = self.position[0] + dir[0]
      y_end = self.position[1] + dir[1]
      until !x_end.between?(0,7) || !y_end.between?(0,7)
        if board[[x_end,y_end]].side != self.side &&
        board[[x_end,y_end]].side != :n
          pos_moves << [x_end,y_end]
          break
        end
        break if board[[x_end,y_end]].present?
        # if board[[x_end,y_end]].class == NullPiece
        # break unless board[[x_end,y_end]].side != self.side
        pos_moves << [x_end,y_end]
        # end
        x_end += dir[0]
        y_end += dir[1]
      end
    end
    pos_moves
  end
end
