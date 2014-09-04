require 'spec_helper'

describe Skill do
  before do
    @skill = FactoryGirl.create(:skill)
  end

  subject { @skill }

  it { should be_valid }

  describe 'code' do
    it 'should have a max length' do
      @skill.code = 'a' * 33
      expect(@skill).to_not be_valid
    end

    it 'should be unique' do
      @skill.save
      skill = @skill.dup
      expect(skill).to_not be_valid
    end
  end
end
