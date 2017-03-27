require 'rspec'
require 'viselitsa/game'

describe Game do
  it 'initialize' do
    game = Game.new('тест')
    expect(game.letters).to eq ['т', 'е', 'с', 'т']
    expect(game.status).to eq :in_progress
  end

  context 'status = :lost' do
    it 'next_step(letter)' do
      game = Game.new('тест')

      game.next_step('ф')
      game.next_step('ш')
      game.next_step('к')
      game.next_step('и')
      game.next_step('ч')
      game.next_step('я')
      game.next_step('з')
      game.next_step('Ы')

      expect(game.errors).to eq 7
      expect(game.status).to eq :lost
    end
  end

  context 'status = :win' do
    it 'next_step(letter)' do
      game = Game.new('тест')

      game.next_step('т')
      game.next_step('е')
      game.next_step('с')

      expect(game.errors).to eq 0
      expect(game.status).to eq :won
    end
  end
end