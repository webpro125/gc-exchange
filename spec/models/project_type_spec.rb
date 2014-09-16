require 'spec_helper'

describe ProjectType do
  before do
    @project_type = ProjectType.new(code: 'MY_PROJECT_TYPE')
  end

  subject { @project_type }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      expect(subject).to ensure_length_of(:code).is_at_most(32)
    end

    it 'should be unique' do
      expect(subject).to validate_uniqueness_of :code
    end

    it 'should be required' do
      expect(subject).to validate_presence_of :code
    end
  end
end
