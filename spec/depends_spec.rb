# frozen_string_literal: true

require 'spec_helper'
require 'pry'

require_relative 'shared/examples/handle_circular_dependencies'
require_relative 'shared/examples/topological_sort'

require_relative 'shared/contexts/very_simple_dependency'
require_relative 'shared/contexts/simple_dependencies'

describe Depends do
  subject(:depends) { described_class.new }

  describe '#add' do
    it 'adds a pair of dependency' do
      # TODO
      # refactor this part after implement the list method
      # shouldn't need to expose RGL::Edge::DirectedEdge
      expect(depends.add(depends_by: 'end', depends_on: 'start').edges.first).to eq(RGL::Edge::DirectedEdge.new('end', 'start'))
    end

    context 'with a very simple circular dependency' do
      include_context 'very simple dependency'
      include_examples 'handle circular dependency'
    end

    context 'with a simple circular dependency do' do
      include_context 'simple dependencies'
      include_examples 'handle circular dependency'
    end
  end

  describe '#sort' do
    context 'with a simple dependency' do
      dependences = [
        { depends_on: 'start', depends_by: 'middle' },
        { depends_on: 'middle', depends_by: 'end' }
      ]

      include_examples 'sort dependency in top-down manner', dependences
    end

    context 'with my morning routine dependency' do
      dependences = [
        { depends_by: 'make breakfast', depends_on: 'wake up' },
        { depends_by: 'eat breakfast', depends_on: 'make breakfast' },
        { depends_by: 'wash up', depends_on: 'wake up' },
        { depends_by: 'clean kitchen', depends_on: 'make breakfast' },
        { depends_by: 'wash the dishes', depends_on: 'eat breakfast' },
        { depends_by: 'dress up', depends_on: 'wash up' },
        { depends_by: 'walk my dog', depends_on: 'wash up' },
        { depends_by: 'make coffee', depends_on: 'wake up' },
        { depends_by: 'have my coffee', depends_on: 'make coffee' },
        { depends_by: 'check my schedule', depends_on: 'have my coffee' }
      ]

      include_examples 'sort dependency in top-down manner', dependences
    end
  end
end
