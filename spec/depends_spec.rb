# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.shared_examples 'handle circular dependency' do
  it 'raise CircularDependenceError if the new dependency create a circle' do
    expect do
      depends.add(depends_on: 'end', depends_by: 'start')
    end.to raise_error(Depends::CircularDependenceError)
  end

  context 'when CircularDependenceError is catched' do
    before do
      begin
        depends.add(depends_on: 'end', depends_by: 'start')
      rescue Depends::CircularDependenceError
      end
    end

    it 'does not have a cycle' do
      expect(depends.instance_variable_get(:@dag).cycles).to be_empty
    end
  end
end

RSpec.shared_examples 'list dependency in top-down manner' do |dependences|
  before do
    dependences.each do |dependency|
      depends.add(dependency)
    end
  end

  it 'lists all dependences that no depends_by will appear before bepends on' do
    dependences.each do |dependency|
      expect(depends.list.find_index(dependency[:depends_by])).to be > depends.list.find_index(dependency[:depends_on])
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
      before { depends.add(depends_on: 'start', depends_by: 'end') }

      include_examples 'handle circular dependency'
    end

    context 'with a little bit complex circular depends do' do
      before do
        depends.add(depends_on: 'start', depends_by: 'middle')
        depends.add(depends_on: 'middle', depends_by: 'end')
      end

      include_examples 'handle circular dependency'
    end
  end

  describe '#list' do
    dependences = [
      { depends_on: 'start', depends_by: 'middle' },
      { depends_on: 'middle', depends_by: 'end' }
    ]

    include_examples 'list dependency in top-down manner', dependences
  end
end
