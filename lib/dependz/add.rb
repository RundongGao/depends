# frozen_string_literal: true

module Dependz
  module Add
    def add(depend_by:, depend_on:)
      forms = depend_by.is_a?(Array) ? depend_by : [depend_by]
      tos = depend_on.is_a?(Array) ? depend_on : [depend_on]

      forms.each do |from|
        tos.each do |to|
          add_dependency(from, to)
        end
      end

      self
    end

    private

    def add_dependency(from, to)
      new_dag = @dag.dup
      new_dag.add_edge(from, to)

      raise CircularDependenceError unless new_dag.cycles.empty?

      @dag = new_dag

      self
    end
  end
end
