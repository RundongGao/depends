# frozen_string_literal: true

RSpec.shared_examples 'sort dependency in top-down manner' do
  it 'lists all dependences that no depends_by will appear before bepends on' do
    dependz.list.each do |dependency|
      expect(dependz.sort_item.find_index(dependency[:depend_by])).to be > dependz.sort_item.find_index(dependency[:depend_on])
    end
  end
end
