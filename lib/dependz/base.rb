# frozen_string_literal: true

module Dependz
  module Base
    attr_reader :dag

    def initialize
      @dag = RGL::DirectedAdjacencyGraph.new
    end
  end
end
