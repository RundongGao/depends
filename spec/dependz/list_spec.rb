# frozen_string_literal: true

require 'spec_helper'

require 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include Dependz::Base
  include Dependz::Add
  include Dependz::List
end

describe Dependz::List do
  let(:dependz) { DependzTestClass.new }

  describe '#list' do
    context 'with a simple dependency' do
      include_context 'with loading dependency fxiture', 'simple_dependency.json'

      it 'list dependencies' do
        expect(dependz.list).to match_array(dependency_fixture('simple_dependency.json').map(&:symbolize_keys))
      end
    end

    context 'with my morning routine dependency' do
      include_context 'with loading dependency fxiture', 'morning_routine_dependency.json'

      it 'list dependencies' do
        list_of_dependencies = [
          {
            depend_by: 'make breakfast',
            depend_on: 'wake up'
          },
          {
            depend_by: 'eat breakfast',
            depend_on: 'make breakfast'
          },
          {
            depend_by: 'wash up',
            depend_on: 'wake up'
          },
          {
            depend_by: 'clean kitchen',
            depend_on: 'make breakfast'
          },
          {
            depend_by: 'wash the dishes',
            depend_on: 'eat breakfast'
          },
          {
            depend_by: 'dress up',
            depend_on: 'wash up'
          },
          {
            depend_by: 'walk my dog',
            depend_on: 'wash up'
          },
          {
            depend_by: 'make coffee',
            depend_on: 'wake up'
          },
          {
            depend_by: 'have my coffee',
            depend_on: 'make coffee'
          },
          {
            depend_by: 'check my schedule',
            depend_on: 'have my coffee'
          },
          {
            depend_by: 'Start the day!',
            depend_on: 'have my coffee'
          },
          {
            depend_by: 'Start the day!',
            depend_on: 'wash up'
          },
          {
            depend_by: 'Start the day!',
            depend_on: 'eat breakfast'
          },
          {
            depend_by: 'Start the day!',
            depend_on: 'check my schedule'
          }
        ]

        expect(dependz.list).to match_array(list_of_dependencies)
      end
    end
  end
end
