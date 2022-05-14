# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#update_display' do
    subject(:board) { Board.new }

    it 'updates board at position with given mark' do
      allow(board).to receive(:display_board)
      board.update_display(3, 'X')
      updated_board = board.instance_variable_get(:@board)
      expect(updated_board[3]).to eq('X')
    end
  end

  describe '#check_board_for_position' do
    context 'player chooses a position that is not filled' do
      subject(:blank_board) { Board.new }
      it 'returns true' do
        expect(blank_board.check_board_for_position(0)).to be_truthy
      end
    end

    context 'player chooses a position that is already filled' do
      subject(:filled_board) { Board.new(%w[X X X X X X X X X]) }
      it 'returns false' do
        allow(filled_board).to receive(:puts)
        expect(filled_board.check_board_for_position(1)).to be_falsey
      end
    end
  end

  describe '#check_board_for_win' do
    context 'there is a row win' do
      subject(:row_win) { described_class.new(%w[X O X X X X O X O]) }

      it 'returns winning mark' do
        expect(row_win.check_board_for_win).to eq('X')
      end
    end

    context 'there is a column win' do
      subject(:col_win) { described_class.new(%w[O X X X X O O X X]) }

      it 'returns winning mark' do
        expect(col_win.check_board_for_win).to eq('X')
      end
    end

    context 'there is a diagonal win' do
      subject(:diag_win) { described_class.new(%w[X O O O X O O O X]) }

      it 'returns winning mark' do
        expect(diag_win.check_board_for_win).to eq('X')
      end
    end

    context 'there is a tie game' do
      subject(:tie_game) { described_class.new(%w[O O X X X O O X X]) }

      it 'returns true' do
        allow(tie_game).to receive(:puts)
        expect(tie_game.check_board_for_win).to be_truthy
      end
    end

    context 'there is not a win' do
      subject(:no_win) { Board.new }

      it 'returns false' do
        expect(no_win.check_board_for_win).to be_falsey
      end
    end
  end
end
