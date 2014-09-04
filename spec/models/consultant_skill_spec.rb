require 'spec_helper'

describe ConsultantSkill do
  before do
    @consultant = FactoryGirl.create(:confirmed_consultant)
    @skill = FactoryGirl.create(:skill)
    @consultant_skill = ConsultantSkill.new(skill: @skill, consultant: @consultant)
  end

  subject { @consultant_skill }

  it { should be_valid }

  describe 'skill_id' do
    it 'should not be valid' do
      @consultant_skill.skill_id = nil
      expect(@consultant_skill).to_not be_valid
    end
  end

  describe 'profile_id' do
    it 'should not be valid' do
      @consultant_skill.profile_id = nil
      expect(@consultant_skill).to_not be_valid
    end
  end
end
