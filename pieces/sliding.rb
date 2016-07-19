

module Sliding
  BISHOP_DELTA = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  ROOK_DELTA = [[1, 0], [-1, 0], [0, -1], [0, 1]]
  QUEEN_DELTA = BISHOP_DELTA + ROOK_DELTA

  def moves_opts(deltas)
    moves = []
    deltas.each do |delta|
      moves += move_in_direction(delta)
      end
      #pos + delta  if its valid
      moves
  end

  def move_in_direction(delta)
    can_move = []
    current_pos = [@pos[0] + delta[0], @pos[1] + delta[1] ]
    while valid_move?(current_pos)
      can_move << current_pos
      break unless @board[current_pos].empty?
      current_pos = [current_pos[0] + delta[0], current_pos[1] + delta[1] ]
    end
    can_move
  end


end
