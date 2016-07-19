require_relative '../board'
require 'colorized_string'
class Piece
  attr_accessor :pos
  def initialize(pos, color, board, unicode)
    @pos = pos
    @color = color
    @unicode = unicode
    @board = board
  end

  def moves
    #defined in subclasses
  end

  def empty?
    false
  end

  def color
    @color
  end



  def dup(board)
    class_piece = self.class
    new_pos = self.pos.dup
    class_piece.new(new_pos, self.color, board)
  end

  def to_s
    " #{@unicode} "
  end

  def find_check_moves
      self.moves.each do |move|
        dup_board = @board.dup
        dup_board.move(@pos, move)
        return move if dup_board.in_check?(oppenent_color)
      end
      []
  end


  private

  def valid_move?(pos)
    @board.in_bounds?(pos) && (@board[pos].empty? ||
     @board[pos].color != self.color)
  end

  def oppenent_color
    @color == :white ? :black : :white
  end




end
