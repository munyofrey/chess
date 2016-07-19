require "colorize"
require_relative "cursorable"
load 'board.rb'

class Display
  include Cursorable

  attr_reader :selected, :cursor_pos

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = false
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
  end

  private
  
  def toggle_selected
    @selected = !@selected
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
    if [i, j] == @cursor_pos && @selected
      bg = :light_green
    elsif [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :light_white
    end
    { background: bg, color: :white }
  end

end
