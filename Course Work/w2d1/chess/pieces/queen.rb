require_relative 'sliding_piece'

class Queen < SlidingPiece
  def move_dirs
    QUEEN_MOVES
  end

  def to_s
    " Q "
  end
end
