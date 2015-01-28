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

end
