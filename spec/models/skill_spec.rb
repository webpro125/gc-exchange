require 'spec_helper'

describe Skill do
  subject { Skill.new(code: 'MY_SKILL') }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      expect(subject).to ensure_length_of(:code).is_at_most(128)
    end

    it 'should be unique' do
      expect(subject).to validate_uniqueness_of(:code).case_insensitive
    end

    it 'should be required' do
      expect(subject).to validate_presence_of :code
    end
  end

  describe 'self.search' do
    it 'should call __elasticsearch__' do
      expect(Skill.__elasticsearch__).to receive(:search)
      Skill.search('oh yea!')
    end
  end
end
