# frozen_string_literal: true

require 'rgl/adjacency'
require 'rgl/topsort'

require 'dependz/add'
require 'dependz/base'
require 'dependz/sort_item'
require 'dependz/list'
require 'dependz/sort_depth'

module Dependz
  class Client
    include Base
    include Add
    include SortItem
    include List
    include SortDepth
  end
end
