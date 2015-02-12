require 'spec_helper'

describe ContactRequest do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  subject do
    ContactRequest.new(
      consultant: consultant,
      user: user,
      subject: 'Test Subject',
      message: 'Test Messages',
      project_start: 1.month.ago,
      project_end: 2.months.from_now,
      contact_status: :pending
    )
  end

  it { should be_valid }
  it { should belong_to(:consultant) }
  it { should belong_to(:user) }
  it { should belong_to(:communication) }

  describe 'association' do
    describe 'consultant' do
      before do
        subject.save!
      end

      it 'should not be deleteed on delete' do
        consultant_id = subject.consultant_id

        subject.delete
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'user' do
      before do
        subject.save!
      end

      it 'should not be deleteed on delete' do
        user_id = subject.user_id

        subject.delete
        expect(User.find_by_id(user_id)).not_to be_nil
      end
    end

    describe 'communication' do
      before do
        subject.save!
      end

      it 'should not be deleteed on delete' do
        communication_id = subject.communication_id

        subject.delete
        expect(Mailboxer::Conversation.find_by_id(communication_id)).not_to be_nil
      end
    end
  end
end
