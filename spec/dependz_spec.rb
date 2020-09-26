

require 'spec_helper'
require 'pry'

require_relative 'shared/examples/handle_circular_dependencies'
require_relative 'shared/examples/topological_sort'

require_relative 'shared/contexts/load_dependency_fixture'

describe Dependz do
  subject(:dependz) { described_class.new }

  describe '#add' do
    it 'adds a pair of dependency' do
      # TODO
      # refactor this part after implement the list method
      # shouldn't need to expose RGL::Edge::DirectedEdge
      expect(dependz.add(depends_by: 'end', depends_on: 'start').instance_variable_get(:@dag).edges.first).to eq(RGL::Edge::DirectedEdge.new('end', 'start'))
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

    context 'with cooking omlette dependency' do
      include_context 'with loading dependency fxiture', 'cook_omelette_dependency.json'
      include_examples 'sort dependency in top-down manner', 'cook_omelette_dependency.json'
      it '' do
        # use dg.instance_variable_get(:@vertices_dict)
        # list all the roots vertices

        require 'rgl/dot'
        dg = dependz.instance_variable_get(:@dag).reverse
        dg.write_to_graphic_file('jpg')
        require 'rgl/traversal'
        vis = RGL::DFSVisitor.new(dg)

        level = 0
        h = {}

        vis.set_examine_vertex_event_handler do |v|
          level += 1
          if h[v].nil?
            h[v] = level
          else
            h[v] = level if h[v] < level
          end
        end
        vis.set_finish_vertex_event_handler  do |v|
          level -= 1
        end

        dg.depth_first_visit('whisk eggs', vis) { |x| }
        binding.pry
        level = 0
        dg.depth_first_visit('melt butter', vis) { |x| }
        binding.pry
        level = 0
        dg.depth_first_visit('wash and chop mushroom', vis) { |x| }
        binding.pry
      end
    end
  end
end
