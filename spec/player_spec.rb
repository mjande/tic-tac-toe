# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#initial_set_up' do
    context 'when setting player 1' do
      subject(:new_player1) { described_class.new }

      context 'with valid input' do
        before do
          allow(new_player1).to receive(:gets).and_return('Bob', 'X')
          allow(new_player1).to receive(:puts)
          new_player1.initial_set_up(1)
        end

        it 'sets name as Bob' do
          expect(new_player1.name).to eq('Bob')
        end

        it 'sets mark as X' do
          expect(new_player1.mark).to eq('X')
        end

        it 'sets @@p1_mark as mark' do
          expect(described_class.used_mark).to eq('X')
        end
      end

      context 'with invalid input' do
        it 'outputs error message' do
          allow(new_player1).to receive(:gets).and_return('Bob', 'Y', 'X')
          error_message = 'ERROR: Try again. Please select X or O.'
          allow(new_player1).to receive(:puts)
          expect(new_player1).to receive(:puts).with(error_message)
          new_player1.initial_set_up(1)
        end
      end
    end

    context 'when setting player 2' do
      subject(:new_player2) { described_class.new }

      before do
        allow(new_player2).to receive(:gets).and_return('James')
        allow(new_player2).to receive(:puts)
        described_class.class_variable_set(:@@used_mark, 'X')
        new_player2.initial_set_up(2)
      end

      it 'sets name as James' do
        expect(new_player2.name).to eq('James')
      end

      it 'sets mark to other mark O' do
        expect(new_player2.mark).to eq('O')
      end
    end
  end
end
