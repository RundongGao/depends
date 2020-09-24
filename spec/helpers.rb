# frozen_string_literal: true

module Helpers
  def dependency_fixture(fixture_file)
    JSON.parse(File.read("spec/fixtures/#{fixture_file}"))
  end
end
