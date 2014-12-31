require 'spec_helper'

describe Background do
  subject do
    Background.new(
      consultant: FactoryGirl.create(:confirmed_consultant, :approved),
      citizen: true,
      convicted: false,
      parole: false,
      illegal_drug_use: false,
      illegal_purchase: false,
      illegal_prescription: false
    )
  end

  it { should be_valid }

  describe 'consultant' do
    it 'should be present' do
      subject.consultant = nil
      expect(subject).not_to be_valid
    end
  end
end
