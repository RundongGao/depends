# frozen_string_literal: true

require 'JSON'

RSpec.shared_context 'with loading dependency fxiture', shared_context: :metadata do |fixture_file|
  before do
    dependency_fixtures = dependency_fixture(fixture_file)

    dependency_fixtures.each do |dependency|
      dependz.add(depend_on: dependency['depend_on'], depend_by: dependency['depend_by'])
    end
  end
end
