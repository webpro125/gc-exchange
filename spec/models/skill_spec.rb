require 'spec_helper'

describe Skill do
  before do
    @skill = Skill.new(code: 'MY_SKILL')
  end

  subject { @skill }

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
