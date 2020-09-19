# frozen_string_literal: true

require 'spec_helper'
require 'pry'

describe Depends do
  subject(:depends) { described_class.new }

  describe '#add' do
    it 'adds a pair of dependency' do
      expect(depends.add(depends_on: 13, depends_by: 19).edges.first).to eq(RGL::Edge::DirectedEdge.new(19, 13))
    end

    it 'raise CircularDependenceError if the new dependency create a circle'

    context 'the CircularDependenceError is catched' do
      it 'does not have a cycle'
    end
  end
end
