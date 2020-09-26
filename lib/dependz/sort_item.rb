# frozen_string_literal: true

module Dependz
  module SortItem
    def sort_item
      dag.topsort_iterator.to_a.reverse
    end
  end
end
