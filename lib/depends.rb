# frozen_string_literal: true

require 'rgl/adjacency'
require 'rgl/topsort'

class Depends
  class CircularDependenceError < StandardError; end

  def initialize
    @dag = RGL::DirectedAdjacencyGraph.new
  end

  def add(depends_by:, depends_on:)
    new_dag = @dag.dup
    new_dag.add_edge(depends_by, depends_on)

    raise CircularDependenceError unless new_dag.cycles.empty?

    @dag = new_dag

    self
  end

  def sort
    @dag.topsort_iterator.to_a.reverse
  end
end
