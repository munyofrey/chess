require_relative 'stepping'
require_relative "piece"
class Knight < Piece
  include Stepping

  def initialize(pos, color, board, unicode=["\u2658", "\u265E"])
    super
  end

  def moves
    moves_opts(KNIGHT_DELTA)
  end

end
