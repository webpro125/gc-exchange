require 'spec_helper'

describe PhoneType do
  before do
    @phone_type = PhoneType.new(code: 'OTHER')
  end

  subject { @phone_type }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      @phone_type.code = 'a' * 33
      expect(@phone_type).to_not be_valid
    end

    it 'should be unique' do
      @phone_type.save
      phone_type = @phone_type.dup
      expect(phone_type).to_not be_valid
    end
  end
end
