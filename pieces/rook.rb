require_relative 'sliding'
require_relative "piece"
class Rook < Piece
  include Sliding

  def initialize(pos, color, board, unicode= "\u265C")
    super
  end

  def moves
    moves_opts(ROOK_DELTA)
  end

end
