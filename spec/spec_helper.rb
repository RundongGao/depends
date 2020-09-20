# frozen_string_literal: true

require 'depends'

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end
