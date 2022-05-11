require_relative '../lib/board'

describe Board do
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
