require_relative 'Piece'

## rook, queen, bishop
class Sliding_Piece < Piece

  def generate_move_set

    moveset = []

    self.class::CLASS_STEPS.each do |possible_step|

      test_position = @position.dup
      test_position[0] += possible_step[0]
      test_position[1] += possible_step[1]

      while valid_move?(test_position)

        ##if there is a collision, and its with your own piece
        if collision_detect(test_position) && @board.board[test_position[0]][test_position[1]].color == @color
          break
        end

        moveset << test_position.dup

        ##if there is a collision and it is with an enemey piece
        if collision_detect(test_position) && @board.board[test_position[0]][test_position[1]].color != @color
          break
        end

        test_position[0] = test_position[0] + possible_step[0]
        test_position[1] = test_position[1] + possible_step[1]

      end
    end

    moveset

  end

  def collision_detect (position)
    @board.board[position[0]][position[1]] != ' '
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
