require 'spec_helper'

describe ClearanceLevel do
  before do
    @clearance_level = FactoryGirl.create(:clearance_level)
  end

  subject { @clearance_level }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      @clearance_level.code = 'a' * 11
      expect(@clearance_level).to_not be_valid
    end

    it 'should be unique' do
      @clearance_level.save
      clearance_level = @clearance_level.dup
      expect(clearance_level).to_not be_valid
    end
  end
end
