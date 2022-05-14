# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#play_game' do
    subject(:first_round) { described_class.new }

    before do
      player1 = double('player1', name: 'Player #1', mark: 'X')
      player2 = double('player2', name: 'Player #2', mark: 'O')
      first_round.instance_variable_set(:@player1, player1)
      first_round.instance_variable_set(:@player2, player2)
      allow(first_round).to receive(:puts)
    end

    context 'when a player wins after three rounds' do
      before do
        allow(first_round).to receive(:play_round).and_return(false, false, true)
        board = instance_double('Board')
        allow(board).to receive(:check_board_for_win).and_return('X')
        first_round.instance_variable_set(:@newboard, board)
      end

      it 'loops three times' do
        expect(first_round).to receive(:play_round).exactly(3).times
        first_round.play_game
      end

      it 'outputs winner message' do
        expect(first_round).to receive(:player1_win_message)
        first_round.play_game
      end

      context 'when players want to play again' do
        it 'starts new game after finishing loop' do
          allow(first_round).to receive(:start_game)
          allow(first_round).to receive(:gets).and_return('Y')
          expect(first_round).to receive(:start_game).once
          first_round.play_game
        end
      end

      context 'when players do not want to play again' do
        it 'does not start new game after finishing loop' do
          allow(first_round).to receive(:gets).and_return('N')
          expect(first_round).not_to receive(:start_game)
          first_round.play_game
        end
      end
    end
    context 'when a player wins after six rounds' do
      before do
        allow(first_round).to receive(:play_round).and_return(false, false, false, false, false, true)
        board = instance_double('Board')
        allow(board).to receive(:check_board_for_win).and_return(nil, nil, nil, nil, nil, nil, 'X')
        first_round.instance_variable_set(:@newboard, board)
      end

      it 'loops six times' do
        expect(first_round).to receive(:play_round).exactly(6).times
        first_round.play_game
      end
    end

    context 'the game ends in a tie' do
      before do
        allow(first_round).to receive(:play_round).and_return(true)
        board = instance_double('Board')
        allow(board).to receive(:check_board_for_win).and_return(true)
        first_round.instance_variable_set(:@newboard, board)
      end

      it 'outputs tie message' do
        expect(first_round).to receive(:tie_game_message)
        first_round.play_game
      end
    end
  end

  describe '#play_round' do
    subject(:round) { described_class.new }
    let(:player1) { double('player1', name: 'Player #1', mark: 'X') }

    context 'when all inputs are valid' do
      before do
        board = double('blank board', check_board_for_position: true, update_display: nil, check_board_for_win: false)
        round.instance_variable_set(:@newboard, board)
        allow(round).to receive(:puts)
        allow(round).to receive(:gets).and_return('1', '2')
      end

      it 'converts valid coordinates to position via #convert_to_position' do
        expect(round).to receive(:convert_to_position).and_return(4)
        round.play_round(player1)
      end

      it 'passes check for #valid_input?' do
        expect(round).to receive(:valid_input?).and_return(true)
        round.play_round(player1)
      end
    end

    context 'when user inputs invalid position' do
      before do
        board = double('blank board', check_board_for_position: true, update_display: nil, check_board_for_win: false)
        round.instance_variable_set(:@newboard, board)
        allow(round).to receive(:puts)
        allow(round).to receive(:gets).and_return('9', '-12', '1', '2')
      end

      it 'initially fails check for #valid_input?' do
        expect(round).to receive(:valid_input?).and_return(false, true)
        round.play_round(player1)
      end
    end

    context 'when user inputs a position that is already taken' do
      before do
        board = double('blank board', update_display: nil, check_board_for_win: false)
        allow(board).to receive(:check_board_for_position).and_return(false, true)
        round.instance_variable_set(:@newboard, board)
        allow(round).to receive(:puts)
        allow(round).to receive(:gets).and_return('1', '1', '1', '2')
      end

      it 'initially fails check for #valid_input?' do
        expect(round).to receive(:valid_input?).and_return(false, true)
        round.play_round(player1)
      end
    end
  end
end
