RSpec.shared_context 'very simple dependency', shared_context: :metadata do
  before { depends.add(depends_on: 'start', depends_by: 'end') }
end
