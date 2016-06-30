require_relative 'sliding_piece'

class Rook < SlidingPiece

  def move_dirs
    ROOK_MOVES
  end

  def to_s
    " R "
  end
end
