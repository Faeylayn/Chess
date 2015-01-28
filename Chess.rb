require_relative 'Piece'
require_relative 'Sliding_Piece'
require_relative 'Stepping_Piece'
require 'byebug'
##Game class and Board class

class CheckError < StandardError
end

class BoundsError < StandardError
end

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8){ Array.new(8) {" "} }
    initialize_pieces
  end

  def initialize_pieces

    @board[0][0] = Rook.new(self, [0,0], "wR ")
    @board[0][1] = Knight.new(self, [0,1], "wKN")
    @board[0][2] = Bishop.new(self, [0,2], "wB ")
    @board[0][3] = Queen.new(self, [0,3], "wQ ")
    @board[0][4] = King.new(self,[0,4], "wKi")
    @board[0][5] = Bishop.new(self, [0,5], "wB ")
    @board[0][6] = Knight.new(self, [0,6], "wKN")
    @board[0][7] = Rook.new(self, [0,7], "wR ")

    8.times do |count|
      @board[1][count] = Pawn.new(self, [1,count], "wP ")

    end

    ##########################################

    @board[7][0] = Rook.new(self, [7,0], "bR ")
    @board[7][1] = Knight.new(self, [7,1], "bKN")
    @board[7][2] = Bishop.new(self, [7,2], "bB ")
    @board[7][3] = Queen.new(self, [7,3], "bQ ")
    @board[7][4] = King.new(self,[7,4], "bKi")
    @board[7][5] = Bishop.new(self, [7,5], "bB ")
    @board[7][6] = Knight.new(self, [7,6], "bKN")
    @board[7][7] = Rook.new(self, [7,7], "bR ")

    8.times do |count|
      @board[6][count] = Pawn.new(self, [6,count], "bP ")

    end

  end

  def display
    puts "================================="
    puts "================================="
    @board.each do |row|
      row.each do |space|
        print " "
        print "___" if space == " "
        print space.name if space != " "
      end
      puts ' '
    end
    puts
  end


  def king_finder(color)

    kings_location = nil

    @board.each do |row|
      row.each do |space|

        next if space == " "

        kings_location = [row,space] if space.name == "#{color}Ki"

      end
    end

    kings_location

  end

  def check_all_enemy_movesets(kings_location,color)

    @board.each do |row|
      row.each do |space|

        next if space == " " || space.color == color

        space.generate_move_set

        return true if space.moveset.include?(kings_location)

      end
    end

    false

  end

  def dup_board

    temp_board = Board.new
    temp_board.board = []

    @board.each do |row|

      new_row = []

      row.each do |space|
        new_row << space.dup
      end

      temp_board.board << new_row
    end

    temp_board

  end

  def in_check?(color)

    ##give us kings location
    kings_location = king_finder(color)

    ##generate move set of all enemy peices
    check_all_enemy_movesets(kings_location,color)

  end

  def make_move(start_pos, end_pos)

    moving_position = @board[ start_pos[0] ] [ start_pos[1] ]

    @board[ start_pos[0] ] [ start_pos[1] ] = " "
    @board[ end_pos[0] ][ end_pos[1] ] = moving_position

  end


end

class Game

  def initialize

    @board = Board.new
    @game_on = true
    @current_color = 'w'
    play

  end

  def play

    puts "\nWelcome to Chess!\n"

    while @game_on

      @board.display

      move = get_user_input

      @board.make_move(move[0], move[1])
      @board[move[1][0]] [move[1][1]].position = move[1]


    end

  end

  def get_user_input

    begin
      start_pos = get_start_piece
      end_pos = get_end_pos
      verify_input(start_pos, end_pos)
    rescue StandardError
      puts "\nYou entered an invalid character. Try again."
    retry
    rescue CheckError
      puts "That move would put you into check."
    retry
  end

    [start_pos, end_pos]

  end

  def get_start_piece

      puts "Enter the position you wish to move from"
      start_position = gets.chomp.split("")

      start_position[0] = start_position[0].to_i
      start_position[1] = start_position[1].to_i

      if start_position.all? {|coord| coord.between?(0,7)}

          test_position = @board.board[start_position[0]][start_position[1]]

        if  test_position != ' ' && test_position.color == @current_color
          return start_position
        end

      end

      raise StandardError

  end

  def get_end_pos

    puts "\nEnter the position you wish to move to"
    end_position = gets.chomp.split("")

    end_position[0] = end_position[0].to_i
    end_position[1] = end_position[1].to_i

    if end_position.all? {|coord| coord.between?(0,7)}

        test_position = @board.board[end_position[0]][end_position[1]]

      if  test_position == ' ' || test_position.color != @current_color
        return end_position
      end

    end

    raise StandardError

  end

  def verify_input(start_pos, end_pos)

    target_pos = @board.board[end_pos[0]][end_pos[1]]
    moving_piece = @board.board[start_pos[0]][start_pos[1]]
    moving_piece.generate_move_set

    raise CheckError if moving_piece.move_into_check?(end_pos)

    return true if moving_piece.moveset.include?(end_pos)

    raise StandardError


  end
end

a = Game.new
