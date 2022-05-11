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
    subject(:board) { Board.new }

    it 'returns winning mark if check_rows is not nil' do
      allow(board).to receive(:check_rows).and_return('X')
      expect(board.check_board_for_win).to eq('X')
    end

    it 'returns winning mark if check_rows is nil' do
      allow(board).to receive(:check_rows).and_return(nil)
      allow(board).to receive(:check_columns).and_return('X')
      expect(board.check_board_for_win).to eq('X')
    end

    it 'returns winning if check_rows and check_columns are nil' do
      allow(board).to receive(:check_rows).and_return(nil)
      allow(board).to receive(:check_columns).and_return(nil)
      allow(board).to receive(:check_diagonals).and_return('X')
      expect(board.check_board_for_win).to eq('X')
    end

    it 'returns nil if all methods return nil' do
      allow(board).to receive(:check_rows).and_return(nil)
      allow(board).to receive(:check_columns).and_return(nil)
      allow(board).to receive(:check_diagonals).and_return(nil)
      expect(board.check_board_for_win).to be_nil
    end
  end

  describe '#check_rows' do
    context 'there is a winning row' do
      subject(:row_win) { Board.new(['X', 'X', 'X', nil, nil, nil, nil, nil, nil]) }
      it 'returns winning mark X' do
        expect(row_win.check_rows).to eq('X')
      end

      subject(:row_win2) { Board.new([nil, nil, nil, nil, nil, nil, 'O', 'O', 'O']) }
      it 'returns winning mark O' do
        expect(row_win2.check_rows).to eq('O')
      end
    end

    context 'there is not a winning row' do
      subject(:no_row_win) { Board.new([nil, nil, nil, nil, nil, nil, nil, nil, nil]) }
      it 'returns nil' do
        expect(no_row_win.check_rows).to be_nil
      end
    end
  end

  describe '#check_columns' do
    context 'there is a winning column' do
      subject(:col_win) { Board.new(['X', nil, nil, 'X', nil, nil,'X', nil, nil]) }
      it 'returns winning mark X' do
        expect(col_win.check_columns).to eq('X')
      end

      subject(:col_win2) { Board.new([nil, nil, 'O', nil, nil, 'O', nil,nil, 'O']) }
      it 'returns winning mark O' do
        expect(col_win2.check_columns).to eq('O')
      end
    end

    context 'there is not a winning row' do
      subject(:no_col_win) { Board.new([nil, nil, nil, nil, nil, nil, nil,nil, nil]) }
      it 'returns nil' do
        expect(no_col_win.check_columns).to be_nil
      end
    end
  end

  describe '#check_diagonals' do
    context 'there is a winning diagonal' do
      subject(:diag_win) { Board.new(['X', nil, nil, nil, 'X', nil, nil, nil, 'X']) }
      it 'returns winning mark X' do
        expect(diag_win.check_diagonals).to eq('X')
      end

      subject(:diag_win2) { Board.new([nil, nil, 'O', nil, 'O', nil, 'O', nil, nil])}
      it 'returns winning mark O' do
        expect(diag_win2.check_diagonals).to eq('O')
      end
    end

    context 'there is not a winning diagonal' do
      subject(:no_diag_win) { Board.new([nil, nil, nil, nil, nil, nil, nil,nil, nil])}
      it 'returns nil' do
        expect(no_diag_win.check_diagonals).to be_nil
      end
    end
  end
end
