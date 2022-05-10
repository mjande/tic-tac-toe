require_relative '../lib/board'

describe Board do
  describe '#check_rows' do
    
    context 'there is a winning row' do
      it 'returns winning mark X' do
        subject(:row_win) { Board.new(['X', 'X', 'X', nil, nil, nil, nil, nil, nil]) }
        expect(row_win.check_rows).to eq('X')
      end
    end
  end
end

    