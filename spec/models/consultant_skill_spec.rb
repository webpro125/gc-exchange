require 'spec_helper'

describe ConsultantSkill do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }
  let(:skill) { FactoryGirl.create(:skill) }

  subject { ConsultantSkill.new(skill: skill, consultant: consultant) }

  it { should be_valid }

  describe 'skill_id' do
    it 'should not be valid' do
      subject.skill = nil
      expect(subject).to_not be_valid
    end

    it 'should be unique' do
      subject.save!
      duplicate = subject.dup
      expect(duplicate).to_not be_valid
    end
  end

  describe 'consultant' do
    it 'should not be valid' do
      subject.consultant = nil
      expect(subject).to_not be_valid
    end
  end
end
