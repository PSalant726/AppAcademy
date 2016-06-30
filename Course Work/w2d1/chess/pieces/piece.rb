require_relative '../board'

class Piece
  attr_reader :position, :side, :board

  def initialize(position, side, board)
    @position = position
    @side = side
    @board = board
  end

  def present?
    true
  end
end
