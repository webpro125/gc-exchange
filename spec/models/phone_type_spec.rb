require 'spec_helper'

describe PhoneType do
  before do
    @phone_type = PhoneType.new(code: 'MY_PHONE_TYPE')
  end

  subject { @phone_type }

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
