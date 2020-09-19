# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.shared_examples 'handle circular dependency' do
  it 'raise CircularDependenceError if the new dependency create a circle' do
    expect do
      depends.add(depends_by: 'end', depends_on: 'start')
    end.to raise_error(Depends::CircularDependenceError)
  end

  context 'when CircularDependenceError is catched' do
    before do
      begin
        depends.add(depends_by: 'end', depends_on: 'start')
      rescue Depends::CircularDependenceError
      end
    end

    it 'does not have a cycle' do
      expect(depends.instance_variable_get(:@dag).cycles).to be_empty
    end
  end
end

describe Depends do
  subject(:depends) { described_class.new }

  describe '#add' do
    it 'adds a pair of dependency' do
      expect(depends.add(depends_by: 13, depends_on: 17).edges.first).to eq(RGL::Edge::DirectedEdge.new(13, 17))
    end

    context 'with simple circular dependency' do
      before { depends.add(depends_by: 'start', depends_on: 'end') }

      include_examples 'handle circular dependency'
    end

    context 'with a little bit complex circular depends do' do
      before do
        depends.add(depends_by: 'start', depends_on: 'middle')
        depends.add(depends_by: 'middle', depends_on: 'end')
      end

      include_examples 'handle circular dependency'
    end
  end
end
