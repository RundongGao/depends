# frozen_string_literal: true

require 'dependz'
require_relative './helpers'

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
  rspec.include Helpers
end
