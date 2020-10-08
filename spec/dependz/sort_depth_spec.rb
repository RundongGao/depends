# frozen_string_literal: true

require 'spec_helper'

require 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include Dependz::Base
  include Dependz::Add
  include Dependz::SortDepth
  include Dependz::List
end

describe Dependz::SortDepth do
  let(:dependz) { DependzTestClass.new }

  describe '#sort_depth' do
    context 'with a simple dependency' do
      include_context 'with loading dependency fxiture', 'cook_omelette_dependency.json'

      it 'sort dependency and group them by depth' do
        expect(dependz.sort_depth).to eq([['whisk eggs', 'wash and chop mushroom', 'melt butter'], ['stir egge', 'stir mushroom'], ['add cheese', 'put stired mushroom aside'], ['add mushroom'], ['serve the omelette']])
      end
    end
  end
end
