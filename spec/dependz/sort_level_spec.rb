# frozen_string_literal: true

require 'spec_helper'

require 'shared/contexts/load_dependency_fixture'

class DependzTestClass
  include Dependz::Base
  include Dependz::Add
  include Dependz::SortLevel
  include Dependz::List
end

describe Dependz::SortLevel do
  let(:dependz) { DependzTestClass.new }

  describe '#sort_level' do
    context 'with a simple dependency' do
      include_context 'with loading dependency fxiture', 'cook_omelette_dependency.json'

      it 'sort dependency and group them by level' do
        expect(dependz.sort_level).to eq([['whisk eggs', 'wash and chop mushroom', 'melt butter'], ['stir egge', 'stir mushroom'], ['add cheese', 'put stired mushroom aside'], ['add mushroom'], ['serve the omelette']])
      end
    end
  end
end
