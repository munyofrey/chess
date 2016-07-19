
class Pawn < Piece
  TOP_MOVES = [1, 0]
  TOP_ATTACKS = [[1, 1], [1, -1]]
  BOTTOM_MOVES = [-1, 0]
  BOTTOM_ATTACKS = [[-1, -1], [-1, 1]]

  def initialize(pos, color, board, unicode=["\u2659", "\u265F"])
    super
    @top = (@color == :black)
    @starting = pos
  end

  def moves
    attack_moves + reg_moves
  end
  #
  # def moves_opts
  #
  # end

  def attack_moves
    moves = []
    attack_deltas.each do |delta|
      curr_move = [delta[0] + pos[0], delta[1] + pos[1]]
      next unless @board.in_bounds?(curr_move)
      moves << curr_move if (@board[curr_move].color == oppenent_color)
    end
    moves
  end

  def reg_moves
    moves = []
    curr_move = [move_deltas[0] + pos[0], move_deltas[1] + pos[1]]
    moves << curr_move if @board[curr_move].empty?
    #depending on how we implement turns we may need to change @starting to value versus boolean
    if @starting = pos
      curr_move = [move_deltas[0] + curr_move[0], move_deltas[1] + curr_move[1]]
      moves << curr_move if @board[curr_move].empty?
    end
    moves
  end

  def attack_deltas
    @top ? TOP_ATTACKS : BOTTOM_ATTACKS
  end

  def move_deltas
    @top ? TOP_MOVES : BOTTOM_MOVES
  end

end
