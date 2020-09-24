# frozen_string_literal: true

require 'depends'
require './helpers'

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
  rspec.include Helpers
end
