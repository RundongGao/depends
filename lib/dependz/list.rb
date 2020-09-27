# frozen_string_literal: true

module Dependz
  module List
    def list
      dag.edges.map do |edge|
        {
          depend_by: edge.to_a[0],
          depend_on: edge.to_a[1]
        }
      end
    end
  end
end
