require 'spec_helper'

describe ConsultantCertification do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }
  let(:certification) { FactoryGirl.create(:certification) }

  subject { ConsultantCertification.new(certification: certification, consultant: consultant) }

  it { should be_valid }

  describe 'certification' do
    it 'should not be valid' do
      subject.certification = nil
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
