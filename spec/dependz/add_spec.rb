# frozen_string_literal: true

require 'spec_helper'

require 'shared/examples/handle_circular_dependencies'
require 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include ::Dependz::Base
  include ::Dependz::Add
end

describe Dependz::Add do
  let(:dependz) { DependzTestClass.new }

  describe '#add' do
    it 'adds a pair of dependency' do
      expect(dependz.add(depend_by: 'end', depend_on: 'start').list.first).to eq({ depend_by: 'end', depend_on: 'start' })
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
