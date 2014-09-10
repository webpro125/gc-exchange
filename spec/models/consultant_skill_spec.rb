require 'spec_helper'

describe ConsultantSkill do
  before do
    @consultant_skill = ConsultantSkill.new(skill: skill, consultant: consultant)
  end

  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }
  let(:skill) { FactoryGirl.create(:skill) }

  subject { @consultant_skill }

  it { should be_valid }

  describe 'skill_id' do
    it 'should not be valid' do
      @consultant_skill.skill = nil
      expect(@consultant_skill).to_not be_valid
    end
  end

  describe 'consultant' do
    it 'should not be valid' do
      @consultant_skill.consultant = nil
      expect(@consultant_skill).to_not be_valid
    end
  end
end
