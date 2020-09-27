# frozen_string_literal: true

require 'rgl/traversal'

module Dependz
  module SortLevel
    def sort_level
      @level_map = {}

      roots(dag).each do |root|
        @level = 0
        visitor = dfs_visitor(dag)
        dag.reverse.depth_first_visit(root, visitor) { |x| }
      end

      @level_map.each_with_object([]) do |item_with_level, result|
        item  = item_with_level[0]
        level = item_with_level[1] - 1

        if result[level].nil?
          result[level] = [item]
        else
          result[level].push(item)
        end
      end
    end

    private

    def dfs_visitor(dag)
      RGL::DFSVisitor.new(dag.reverse).tap do |visitor|
        visitor.set_examine_vertex_event_handler do |v|
          @level += 1
          if @level_map[v].nil?
            @level_map[v] = @level
          else
            @level_map[v] = @level if @level_map[v] < @level
          end
        end

        visitor.set_finish_vertex_event_handler do |_v|
          @level -= 1
        end
      end
    end

    def roots(_dag)
      depend_ons = list.map { |d| d[:depend_on] }.uniq
      depend_bys = list.map { |d| d[:depend_by] }.uniq

      depend_ons.reject { |head| depend_bys.include?(head) }
    end
  end
end
