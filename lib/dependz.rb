# frozen_string_literal: true

require 'rgl/adjacency'
require 'rgl/topsort'

require 'dependz/add'
require 'dependz/base'
require 'dependz/sort_item'

module Dependz
  class Client
    include Base
    include Add
    include SortItem
  end
end
