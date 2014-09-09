require 'spec_helper'

describe Rank do
  before do
    @rank = FactoryGirl.create(:rank)
  end

  subject { @rank }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      @rank.code = 'a' * 11
      expect(@rank).to_not be_valid
    end

    it 'should be unique' do
      @rank.save
      rank = @rank.dup
      expect(rank).to_not be_valid
    end
  end
end
