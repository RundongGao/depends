# frozen_string_literal: true

require 'rgl/adjacency'
require 'rgl/topsort'

require 'dependz/add'

module Dependz
  class CircularDependenceError < StandardError; end

  class Client
    include Add

    def initialize
      @dag = RGL::DirectedAdjacencyGraph.new
    end

    def sort
      @dag.topsort_iterator.to_a.reverse
    end
  end
end
