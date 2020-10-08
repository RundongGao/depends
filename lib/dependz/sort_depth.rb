# frozen_string_literal: true

require 'rgl/traversal'

module Dependz
  module SortDepth
    def sort_depth
      depth_of_all_item = roots
                          .map { |root| calculate_depth_from_root(dag, root) }
                          .reduce { |acc, depths| acc.merge(depths) { |_key, a, b| [a, b].max } }

      format(depth_of_all_item)
    end

    private

    def format(depth_mapping)
      depth_mapping.each_with_object([]) do |item_depth, result|
        item  = item_depth[0]
        depth = item_depth[1] - 1

        if result[depth].nil?
          result[depth] = [item]
        else
          result[depth].push(item)
        end
      end
    end

    def calculate_depth_from_root(dag, root)
      @depth = 0
      @depth_map = {}

      visitor = dfs_visitor(dag)
      dag.reverse.depth_first_visit(root, visitor) { |x| }

      @depth_map
    end

    def dfs_visitor(dag)
      RGL::DFSVisitor.new(dag.reverse).tap do |visitor|
        visitor.set_examine_vertex_event_handler do |v|
          @depth += 1
          @depth_map[v] = @depth
        end

        visitor.set_finish_vertex_event_handler do |_v|
          @depth -= 1
        end
      end
    end

    def roots
      depend_ons = list.map { |d| d[:depend_on] }.uniq
      depend_bys = list.map { |d| d[:depend_by] }.uniq

      depend_ons.reject { |head| depend_bys.include?(head) }
    end
  end
end
