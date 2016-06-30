require_relative 'stepping_piece'

class Knight < SteppingPiece
  def move_dirs
    KNIGHT_MOVES
  end

  def to_s
    " N "
  end
end
