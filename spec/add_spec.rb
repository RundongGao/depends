# frozen_string_literal: true

require 'spec_helper'

require_relative 'shared/examples/handle_circular_dependencies'
require_relative 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include ::Dependz::Base
  include ::Dependz::Add
end

describe Dependz::Add do
  let(:dependz) { DependzTestClass.new }

  describe '#add' do
    it 'adds a pair of dependency' do
      # TODO
      # refactor this part after implement the list method
      # shouldn't need to expose RGL::Edge::DirectedEdge
      expect(dependz.add(depend_by: 'end', depend_on: 'start').instance_variable_get(:@dag).edges.first).to eq(RGL::Edge::DirectedEdge.new('end', 'start'))
    end

    context 'with a very simple circular dependency' do
      include_context 'with loading dependency fxiture', 'very_simple_dependency.json'
      include_examples 'handle circular dependency', { depend_by: 'start', depend_on: 'end' }
    end

    context 'with a simple circular dependency' do
      include_context 'with loading dependency fxiture', 'simple_dependency.json'
      include_examples 'handle circular dependency', { depend_by: 'start', depend_on: 'end' }
    end

    context 'with my morning routine dependency' do
      include_context 'with loading dependency fxiture', 'morning_routine_dependency.json'
      include_examples 'handle circular dependency', { depend_by: 'wake up', depend_on: 'have my coffee' }
    end
  end
end
