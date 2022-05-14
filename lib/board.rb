# frozen_string_literal: true

require_relative 'game'

# Board class: variables and methods relating to the state of the board,
# including display, board array, and board checks (for win and occupied spots)
class Board
  attr_accessor :board

  def initialize(board = Array.new(9, nil))
    @board = board
  end

  def display_board
    display = @board.map { |position| position.nil? ? ' ' : position }
    puts "#{display[0]} | #{display[1]} | #{display[2]}"
    puts '---------'
    puts "#{display[3]} | #{display[4]} | #{display[5]}"
    puts '---------'
    puts "#{display[6]} | #{display[7]} | #{display[8]}"
  end

  def update_display(position, mark)
    @board[position.to_i] = mark
    display_board
  end

  def check_board_for_position(position)
    if board[position].nil?
      true
    else
      display_board
      false
    end
  end

  def check_board_for_win
    if !check_rows.nil?
      check_rows
    elsif !check_columns.nil?
      check_columns
    elsif !check_diagonals.nil?
      check_diagonals
    else
      tie_game?
    end
  end

  private

  def check_rows
    if !@board[0].nil? && @board[0] == @board[1] && @board[1] == @board[2]
      @board[0]
    elsif !@board[3].nil? && @board[3] == @board[4] && @board[4] == @board[5]
      @board[3]
    elsif !@board[6].nil? && @board[6] == @board[7] && @board[7] == @board[8]
      @board[6]
    end
  end

  def check_columns
    if !@board[0].nil? && @board[0] == @board[3] && @board[3] == @board[6]
      @board[0]
    elsif !@board[1].nil? && @board[1] == @board[4] && @board[4] == @board[7]
      @board[1]
    elsif !@board[2].nil? && @board[2] == @board[5] && @board[5] == @board[8]
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

  def tie_game?
    if @board.none?(nil)
      puts 'Tie game!'
      true
    else
      false
    end
  end
end
