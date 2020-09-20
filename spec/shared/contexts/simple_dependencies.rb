# frozen_string_literal: true

RSpec.shared_context 'simple dependencies', shared_context: :metadata do
  before do
    depends.add(depends_on: 'start', depends_by: 'middle')
    depends.add(depends_on: 'middle', depends_by: 'end')
  end
end
