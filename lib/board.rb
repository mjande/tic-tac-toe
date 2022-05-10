require_relative 'game'

# Board class: variables and methods relating to the state of the board,
# including display, board array, and board checks (for win and occupied spots)
class Board
  BLANK = ' '
  attr_accessor :board

  def initialize(board = Array.new(9, BLANK))
    @board = board
  end

  def display_board
    puts "#{board[0]} | #{board[1]} | #{board[2]}"
    puts '---------'
    puts "#{board[3]} | #{board[4]} | #{board[5]}"
    puts '---------'
    puts "#{board[6]} | #{board[7]} | #{board[8]}"
  end

  def update_display(position, mark)
    board[position.to_i] = mark
    display_board
  end

  def check_board_for_win
    check_rows
    check_columns if check_columns.nil?
    check_diagonals if check_columns.nil?
  end

  def check_rows
    if @board[0] == @board[1] && @board[1] == @board[2]
      @board[0]
    elsif @board[3] == @board[4] && @board[4] == @board[5]
      @board[3]
    elsif @board[6] == @board[7] && @board[7] == @board[8]
      @board[6]
    end
  end

  def check_columns
    if @board[0] == @board[3] && @board[3] == @board[6]
      @board[0]
    elsif @board[1] == @board[4] && @board[4] == @board[7]
      @board[1]
    elsif @board[2] == @board[5] && @board[5] == @board[8]
      @board[2]
    end
  end

  def check_diagonals
    if @board[0] == @board[4] && @board[0] == @board[8]
      @board[0]
    elsif @board[2] == @board[4] && @board[4] == @board[6]
      @board[2]
    end
  end



  def check_board_for_position(position)
    if board[position] == BLANK
      true
    else
      puts 'ERROR: that position is already taken'
      false
    end
  end
end