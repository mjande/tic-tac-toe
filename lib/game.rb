# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game class data: variables and methods relating to gameplay and user
# interaction functions
class Game
  attr_reader :player1, :player2
  attr_accessor :win, :newboard

  def initialize
    @win == false
  end

  def start_game
    @newboard = Board.new
    puts "Let's play Tic-Tac-Toe"
    create_players
    puts "#{@player1.name} vs #{@player2.name}. Let's play!"
    play_game
  end

  def create_players
    @player1 = Player.new
    @player1.initial_set_up(1)
    @player2 = Player.new
    @player2.initial_set_up(2)
  end

  def play_game
    player = @player1
    end_game = false
    while end_game == false
      end_game = play_round(player)
      player = (player == @player1 ? @player2 : @player1) # Switch players
    end
    determine_winner
    play_again
  end

  def play_round(player)
    position = loop do
      puts "#{player.name}, choose a row:"
      row = gets.chomp.to_i
      puts "#{player.name}, choose a column:"
      col = gets.chomp.to_i
      position = convert_to_position(row, col)
      break position if valid_input?(position)
    end
    @newboard.update_display(position, player.mark)
    @newboard.check_board_for_win
  end

  private

  def valid_input?(position)
    if !position.between?(0, 8)
      puts 'Please enter valid coordinates between 1 and 3.'
      false
    elsif !@newboard.check_board_for_position(position)
      puts 'That position is already taken. Please choose a different position.'
      false
    else
      true
    end
  end

  def convert_to_position(row, col)
    col + ((row - 1) * 3) - 1
  end

  def determine_winner
    winning_mark = @newboard.check_board_for_win
    if winning_mark == @player1.mark
      player1_win_message
    elsif winning_mark == @player2.mark
      player2_win_message
    else
      tie_game_message
    end
  end

  def player1_win_message
    puts "#{@player1.name} wins!"
  end

  def player2_win_message
    puts "#{@player2.name} wins!"
  end

  def tie_game_message
    puts 'Tie game!'
  end

  def play_again
    puts 'Play again? (Y or N)'
    response = gets.chomp.upcase
    if response == 'Y'
      start_game
    else
      puts 'Thanks for playing!'
    end
  end
end
