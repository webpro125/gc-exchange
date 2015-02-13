require 'spec_helper'

describe ContactRequestForm do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  subject do
    ContactRequestForm.new(
      ContactRequest.new(
        consultant: consultant,
        user: user,
        subject: 'Test Subject',
        message: 'Test message',
        project_start: 1.month.from_now,
        project_end: 2.months.from_now))
  end

  it { should be_valid }

  describe 'message' do
    it { should validate_presence_of(:message) }
  end

  describe 'subject' do
    it { should validate_presence_of(:subject) }
  end
end
