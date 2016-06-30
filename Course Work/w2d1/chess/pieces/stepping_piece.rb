require_relative 'piece'
require 'byebug'

class SteppingPiece < Piece

  KING_MOVES = [
    [1,1],
    [1,0],
    [1,-1],
    [-1,1],
    [-1,0],
    [-1,-1],
    [0,1],
    [0,-1]
  ]

  KNIGHT_MOVES = [
    [1,2],
    [1,-2],
    [2,1],
    [2,-1],
    [-2,1],
    [-2,-1],
    [-1,2],
    [-1,-2]
  ]

  def moves
    # debugger
    dirs = self.move_dirs
    pos_moves = []
    dirs.each do |dir|
      x_end = self.position[0] + dir[0]
      y_end = self.position[1] + dir[1]
      if x_end.between?(0,7) && y_end.between?(0,7)
        if board[[x_end,y_end]].side != self.side &&
        board[[x_end,y_end]].side != :n
          pos_moves << [x_end,y_end]
        end
        unless board[[x_end,y_end]].present? #||
        # board[[x_end,y_end]].side == self.side
          pos_moves << [x_end,y_end]
        end
      end
    end
    pos_moves
  end
end
