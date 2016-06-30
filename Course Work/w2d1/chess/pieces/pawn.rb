require_relative 'piece'
require 'byebug'

class Pawn < Piece

  WHITE_PAWN_MOVES = [
    [-2,0],
    [-1, 0],
    [-1,1],
    [-1,-1]
  ]

  BLACK_PAWN_MOVES = [
    [2,0],
    [1, 0],
    [1,1],
    [1,-1]
  ]

  # def move_dirs
  #   PAWN_MOVES
  # end

  def to_s
    " P "
  end

  def moves
    # debugger
    dirs = narrow_dirs
    pos_moves = []
    dirs.each do |move|
      x_end = self.position[0] + move[0]
      y_end = self.position[1] + move[1]
      if x_end.between?(0,7) && y_end.between?(0,7)
        if move[1] == 0 && board[[x_end,y_end]] == board.null
          pos_moves << [x_end, y_end]
        elsif move[1] != 0
          pos_moves << [x_end, y_end]
        end
      end
    end
    pos_moves
  end

  private

  def narrow_dirs
    if self.side == :w
      dirs = WHITE_PAWN_MOVES.dup
      # dirs = PAWN_MOVES.map { |move| [move[0] * -1, move[1]] }
    else
      dirs = BLACK_PAWN_MOVES.dup
    end
    captures = dirs.last(2)         #6,3    #5,2
    captures.each do |move|
      x_end = self.position[0] + move[0]
      y_end = self.position[1] + move[1]
      dirs.delete(move) unless y_end.between?(0,7)
      dirs.delete(move) unless x_end.between?(0,7)
      if x_end.between?(0,7) && y_end.between?(0,7)
        if board[[x_end,y_end]].side == self.side || board[[x_end,y_end]].is_a?(NullPiece)
          dirs.delete(move)
        end
      end
    end
    # debugger
    x_end = self.position[0] + dirs[1][0]
    y_end = self.position[1] + dirs[1][1]
    dirs.shift unless !board[[x_end,y_end]].present? && (self.position[0] == 1 || self.position[0] == 6)
    dirs
  end

end
