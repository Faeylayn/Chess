require_relative 'Piece'

## rook, queen, bishop
class Sliding_Piece < Piece

  def generate_move_set
    @moveset = []
    self.class::CLASS_STEPS.each do |possible_step|
      test_position = @position
      test_position += possible_step
      while valid_move?(test_position)

        @moveset << test_position
#       break if @board.occupied?(test_position)
        test_position += possible_step
      end
    end
  end

end

class Rook < Sliding_Piece

  CLASS_STEPS = HORIZONTAL_STEPS + VERTICAL_STEPS

end


class Queen < Sliding_Piece

  CLASS_STEPS = HORIZONTAL_STEPS + VERTICAL_STEPS + DIAGONAL_STEPS

end

class Bishop < Sliding_Piece

  CLASS_STEPS = DIAGONAL_STEPS

end
