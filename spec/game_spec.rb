require_relative '../lib/game'

describe Game do
  describe '#start_game' do
    subject(:new_game) { described_class.new }

    before do
      allow(new_game).to receive(:assign_player1)
      allow(new_game).to receive(:assign_player2)
      allow(new_game).to receive(:play_game)
    end
    
    it 'sends message to assign_player1' do
      expect(new_game).to receive(:assign_player1).once
      new_game.start_game
    end

    it 'sends message to assign_player2' do
      expect(new_game).to receive(:assign_player2).once
      new_game.start_game
    end

    it 'sends message to play_game' do
      expect(new_game).to receive(:play_game).once
      new_game.start_game
    end
  end

  describe "#assign_player1" do
    subject(:new_game) { described_class.new }

    before do
      allow(new_game).to receive(:gets).and_return('name')
      allow(new_game).to receive(:choose_mark).and_return('X')
    end

    it 'updates player1 from player input' do
      allow(new_game).to receive(:gets).and_return('name')
      allow(new_game).to receive(:choose_mark).and_return('X')
      new_game.assign_player1
      name = new_game.instance_variable_get(:@player1)
      expect(name).to eq('name')
    end

    it 'updates player1_mark from #choose_mark' do
      new_game.assign_player1
      mark = new_game.instance_variable_get(:@player1_mark)
      expect(mark).to eq('X')
    end
  end

  describe '#choose_mark' do
    subject(:new_game) { described_class.new }
    
    context 'player inputs a valid mark' do
      it 'returns mark' do
        allow(new_game).to receive(:gets).and_return('O')
        expect(new_game.choose_mark).to eq('O')
      end
    end

    context 'player inputs an invalid mark, followed by a valid one' do
      it 'returns first valid mark' do
        allow(new_game).to receive(:gets).and_return('z', 'X')
        expect(new_game.choose_mark).to eq('X')
      end
    end
  end
end
    
      
