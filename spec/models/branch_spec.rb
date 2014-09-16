require 'spec_helper'

describe Branch do
  before do
    @branch = Branch.new(code: 'MY_BRANCH')
  end

  subject { @branch }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      expect(subject).to ensure_length_of(:code).is_at_most(10)
    end

    it 'should be unique' do
      expect(subject).to validate_uniqueness_of :code
    end

    it 'should be required' do
      expect(subject).to validate_presence_of :code
    end
  end
end
