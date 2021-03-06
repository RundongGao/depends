# frozen_string_literal: true

require 'spec_helper'

require 'shared/examples/topological_sort'
require 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include Dependz::Base
  include Dependz::Add
  include Dependz::SortItem
end

describe Dependz::SortItem do
  let(:dependz) { DependzTestClass.new }

  describe '#sort_item' do
    context 'with a simple dependency' do
      include_context 'with loading dependency fxiture', 'simple_dependency.json'
      include_examples 'sort dependency in top-down manner'
    end

    context 'with my morning routine dependency' do
      include_context 'with loading dependency fxiture', 'morning_routine_dependency.json'
      include_examples 'sort dependency in top-down manner'
    end
  end
end
