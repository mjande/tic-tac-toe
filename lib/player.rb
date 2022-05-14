# frozen_string_literal: true

# The Player class stores the methods to set up the players at the start of the
# game, and scripts the printed commands for that process.
class Player
  attr_reader :name, :mark, :used_mark

  @@used_mark = nil

  def initial_set_up(num)
    if num == 1
      assign_player1
    else
      assign_player2
    end
  end

  def self.used_mark
    @@used_mark
  end

  private

  def assign_player1
    puts 'Player 1: Input name below.'
    @name = gets.chomp
    @mark = choose_mark
    @@used_mark = @mark
  end

  def choose_mark
    responses = %w[X O]

    loop do
      puts 'Player 1: Would you like to play X or O?'
      mark = gets.chomp.upcase.strip
      return mark if responses.include?(mark)

      puts 'ERROR: Try again. Please select X or O.'
    end
  end

  def assign_player2
    puts 'Player 2: Input name below.'
    @name = gets.chomp
    @mark = choose_other_mark
  end

  def choose_other_mark
    return 'X' if @@used_mark == 'O'
    return 'O' if @@used_mark == 'X'
  end
end
