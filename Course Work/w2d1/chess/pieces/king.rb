require_relative 'stepping_piece'

class King < SteppingPiece
  def move_dirs
    KING_MOVES
  end

  def to_s
    " K "
  end
end
