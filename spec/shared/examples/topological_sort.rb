# frozen_string_literal: true

RSpec.shared_examples 'sort dependency in top-down manner' do |dependences|
  before do
    dependences.each do |dependency|
      depends.add(**dependency)
    end
  end

  it 'lists all dependences that no depends_by will appear before bepends on' do
    dependences.each do |dependency|
      expect(depends.sort.find_index(dependency[:depends_by])).to be > depends.sort.find_index(dependency[:depends_on])
    end
  end
end
