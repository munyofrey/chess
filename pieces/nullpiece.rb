require 'singleton'

class NullPiece
  include Singleton

  def moves
    []
  end

  def empty?
    true
  end

  def to_s
    '   '
  end

  def color
    :none
  end

  def dup(board)
    NullPiece.instance
  end

end
