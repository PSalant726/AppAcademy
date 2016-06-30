require_relative 'game'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/null_piece'
require 'byebug'

class Board
  attr_reader :grid, :null

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @null = NullPiece.instance
    setup_board
  end

  PIECES = [
    Rook,
    Knight,
    Bishop,
    Queen,
    King,
    Bishop,
    Knight,
    Rook
  ]

  #raise exception if invalid move -- no piece at start, or can't move to end
  def move(start, end_pos) #([6,4],[4,4])
    piece = grid[start]
    #raise unless piece.is_a?(Piece)
    if piece.valid_move?
      grid[start_pos] = nil
      grid[end_pos] = piece
    end
  end

  def setup_board
    place_not_pawns(:w)
    place_pawns(:w)
    place_not_pawns(:b)
    place_pawns(:b)
    place_nulls
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def rows
    @grid
  end

  def full?
    @grid.all? do |row|
      row.all? { |piece| piece.present? }
    end
  end

  def mark(pos)
    x, y = pos
    @grid[x][y] = :P
  end

  def in_check?(color)
    king_loc = find_piece(King, color).first
    threatened_pos = []
    grid.each_with_index do |row, r_idx|
      row.each_with_index do |col, c_idx|
        unless col == null
          threatened_pos.concat(col.moves)
          threatened_pos = threatened_pos.uniq
        end
      end
    end
    return true if threatened_pos.include?(king_loc)
    false
  end

  # def checkmate?(color)
  #   king_loc = find_piece(King, color).first
  #   in_check?(color) &&
  # end

  private

  def place_not_pawns(color)
    PIECES.each_with_index do |piece, idx|
      row = color == :w ? 7 : 0
      pos = [row, idx]
      self[pos] = piece.new(pos, color, self)
    end
  end

  def place_pawns(color)
    row = color == :w ? 6 : 1
    grid[row].each_with_index do |col, idx|
      pos = [row, idx]
      self[pos] = Pawn.new(pos, color, self)
    end
  end

  def place_nulls
    grid.each_with_index do |row, i|
      row.each_index do |j|
        self[[i,j]] = null if self[[i,j]].nil?
      end
    end
  end

  def find_piece(piece_class, color)
    locations = []
    grid.each_with_index do |row, r_idx|
      row.each_with_index do |col, c_idx|
        if col.is_a?(piece_class) &&
          col.side == color
          locations << [r_idx, c_idx]
        end
      end
    end
    locations
  end
end

# TODO: Possible refactoring suggesstion: Create a double_iterate method that takes a block and executes the block on each space on the board!
