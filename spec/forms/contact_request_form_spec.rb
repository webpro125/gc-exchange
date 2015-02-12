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

  describe 'project_start' do
    it 'should be less than today' do
      subject.project_start = 5.minutes.ago
      expect(subject).to be_valid
    end

    it 'should be today' do
      subject.project_start = DateTime.now
      expect(subject).to be_valid
    end

    it 'should not be greater than project_end' do
      subject.project_start = 3.months.from_now
      expect(subject).not_to be_valid
    end
  end

  describe 'project_end' do
    it { should_not validate_presence_of(:project_end) }

    it 'should be greater than today' do
      subject.project_end = 3.months.from_now
      expect(subject).to be_valid
    end

    it 'should not be less than project_start' do
      subject.project_end = 3.years.ago
      expect(subject).not_to be_valid
    end

    it 'can be equal to start date' do
      subject.project_end = subject.project_start
      expect(subject).to be_valid
    end
  end

  describe 'message' do
    it { should validate_presence_of(:message) }
  end

  describe 'subject' do
    it { should validate_presence_of(:subject) }
  end
end
