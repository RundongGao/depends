# frozen_string_literal: true

RSpec.shared_examples 'handle circular dependency' do |dependency|
  it 'raise CircularDependenceError if the new dependency create a circle' do
    expect do
      depends.add(**dependency)
    end.to raise_error(Depends::CircularDependenceError)
  end

  context 'when CircularDependenceError is catched' do
    before do
      begin
        depends.add(**dependency)
      rescue Depends::CircularDependenceError
      end
    end

    it 'does not have a cycle' do
      expect(depends.instance_variable_get(:@dag).cycles).to be_empty
    end
  end
end
