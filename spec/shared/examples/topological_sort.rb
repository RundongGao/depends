# frozen_string_literal: true

RSpec.shared_examples 'sort dependency in top-down manner' do |fixture_file|
  it 'lists all dependences that no depends_by will appear before bepends on' do
    dependency_fixture(fixture_file).each do |dependency|
      expect(dependz.sort.find_index(dependency['depend_by'])).to be > dependz.sort.find_index(dependency['depend_on'])
    end
  end
end
