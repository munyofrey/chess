module Stepping
  KING_DELTA = [[1, 1], [-1, -1], [1, -1], [-1, 1], [1, 0], [-1, 0], [0, -1], [0, 1]]
  KNIGHT_DELTA = [[-2, 1], [-2, -1], [-1, 2], [-1, -2], [2, 1], [2, -1], [1, -2], [1, 2]]

  private

  def moves_opts(deltas)
    moves = []
    deltas.each do |delta|
      curr_move = [@pos[0] + delta[0], @pos[1] + delta[1]]
      moves << curr_move if valid_move?(curr_move)
    end
    moves
  end


end
