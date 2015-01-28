require_relative 'Piece'

##Knight, King, Pawn
class King < Piece

  MOVE_DELTA = HORIZONTAL_STEPS + VERTICAL_STEPS + DIAGONAL_STEPS

  def generate_move_set

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

  def generate_move_set

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

  def pawn_valid?(position)
    valid_move?(position) #&& !@board.occupied_by_enemy?(position)
  end

  def generate_move_set

    @moveset = []

    if @color == 'w'
      move_delta = MOVE_DELTA_W
    else
      move_delta = MOVE_DELTA_B
    end

    if pawn_valid?(@position + move_delta[0])
      @moveset << @position + move_delta[0]

      if pawn_valid?(@position + move_delta[1]) && @moved == false
        @moveset << @position + move_delta[1]
      end

    end

    @moveset << @position + move_delta[2] #if @board.occupied_by_enemy?(@position + move_delta[2])

    @moveset << @position + move_delta[3] #if @board.occupied_by_enemy?(@position + move_delta[3])

  end

end
