require 'colorize'
require_relative 'cursorable'
require 'byebug'
class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    # debugger
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :green
    else
      bg = :white
    end
      if @board[[i,j]] == @board.null
        { background: bg }
      elsif @board[[i,j]].side == :b
        { background: bg, color: :black }
      else
        { background: bg, color: :light_black }
      end
  end

  def render
    system("clear")
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end
end
