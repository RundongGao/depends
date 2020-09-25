# frozen_string_literal: true

require 'spec_helper'
require 'pry'

require_relative 'shared/examples/handle_circular_dependencies'
require_relative 'shared/examples/topological_sort'

require_relative 'shared/contexts/load_dependency_fixture'

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
      include_context 'with loading dependency fxiture', 'very_simple_dependency.json'
      include_examples 'handle circular dependency', { depends_by: 'start', depends_on: 'end' }
    end

    context 'with a simple circular dependency' do
      include_context 'with loading dependency fxiture', 'simple_dependency.json'
      include_examples 'handle circular dependency', { depends_by: 'start', depends_on: 'end' }
    end

    context 'with my morning routine dependency' do
      include_context 'with loading dependency fxiture', 'morning_routine_dependency.json'
      include_examples 'handle circular dependency', { depends_by: 'wake up', depends_on: 'have my coffee' }
    end
  end

  describe '#sort' do
    context 'with a simple dependency' do
      include_context 'with loading dependency fxiture', 'simple_dependency.json'
      include_examples 'sort dependency in top-down manner', 'simple_dependency.json'
    end

    context 'with my morning routine dependency' do
      include_context 'with loading dependency fxiture', 'morning_routine_dependency.json'
      include_examples 'sort dependency in top-down manner', 'morning_routine_dependency.json'
    end
  end
end
