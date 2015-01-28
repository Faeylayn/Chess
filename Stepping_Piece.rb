require_relative 'Piece'

##Knight, King, Pawn
class King < Piece

  MOVE_DELTA = HORIZONTAL_STEPS + VERTICAL_STEPS + DIAGONAL_STEPS

  def move_set

    @moveset = []

    MOVE_DELTA.each do |delta|

      test_position = @position + delta
      @moveset << test_position if valid_move?(test_position)

    end

  end

end

class Knight < Piece

  MOVE_DELTA = [
    [1,2],
    [1,-2],
    [-1,2],
    [-1,-2],
    [2,1],
    [2,-1],
    [-2,1],
    [-2,-1]
  ]

  def move_set

    @moveset = []

    MOVE_DELTA.each do |delta|

      test_position = @position + delta
      @moveset << test_position if valid_move?(test_position)

    end

  end

end

class Pawn < Piece

  MOVE_DELTA_W = [
    [1,0],
    [2,0],

    [1,-1],
    [1,1]
  ]

  MOVE_DELTA_B = [
    [-1,0],
    [-2,0],

    [-1,-1],
    [-1,1]
  ]

  def initialize(board, start_position, name)

    super(board, start_position, name)
    @moved = false

  end

  def move_set

    @moveset = []

    if @color == 'w'
      move_delta = MOVE_DELTA_W
    else
      move_delta = MOVE_DELTA_B
  end

end
