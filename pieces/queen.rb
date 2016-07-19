require_relative 'sliding'
require_relative "piece"
class Queen < Piece
  include Sliding

  def initialize(pos, color, board, unicode="\u265B")
    super
  end

  def moves
    moves_opts(QUEEN_DELTA)
  end

end
