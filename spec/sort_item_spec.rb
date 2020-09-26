# frozen_string_literal: true

require 'spec_helper'

require_relative 'shared/examples/topological_sort'
require_relative 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include Dependz::Base
  include Dependz::Add
  include Dependz::SortItem
end

describe Dependz::SortItem do
  let(:dependz) { DependzTestClass.new }

  describe '#sort' do
    context 'with a simple dependency' do
      include_context 'with loading dependency fxiture', 'simple_dependency.json'
      include_examples 'sort dependency in top-down manner', 'simple_dependency.json'
    end

    xcontext 'with my morning routine dependency' do
      include_context 'with loading dependency fxiture', 'morning_routine_dependency.json'
      include_examples 'sort dependency in top-down manner', 'morning_routine_dependency.json'
    end
  end
end
