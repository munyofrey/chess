require_relative 'stepping'
require_relative "piece"
class King < Piece
  include Stepping

  def initialize(pos, color, board, unicode= "\u265A")
    super
  end

  def moves
    moves_opts(KING_DELTA)
  end

end
