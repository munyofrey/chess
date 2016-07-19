require_relative 'sliding'
require_relative "piece"
class Bishop < Piece
  include Sliding

  def initialize(pos, color, board, unicode= "\u265D")
    super
  end

  def moves
    moves_opts(BISHOP_DELTA)
  end

end
