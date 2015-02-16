require 'spec_helper'

describe ContactRequest do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }
  let!(:travel_authorization) { FactoryGirl.create(:travel_authorization) }

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

      it 'should not be deleted on delete' do
        consultant_id = subject.consultant_id

        subject.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'user' do
      before do
        subject.save!
      end

      it 'should not be deleted on delete' do
        user_id = subject.user_id

        subject.destroy
        expect(User.find_by_id(user_id)).not_to be_nil
      end
    end

    describe 'communication' do
      before do
        subject.save!
      end

      it 'should be deleted on delete' do
        communication_id = subject.communication_id

        subject.destroy
        expect(Mailboxer::Conversation.find_by_id(communication_id)).to be_nil
      end
    end
  end
end
