require 'spec_helper'

describe ContactRequest do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  subject do
    ContactRequest.new(
      consultant: consultant,
      user: user,
      project_start: 1.month.ago,
      project_end: 2.months.from_now,
      message: 'Test message'
    )
  end

  it { should be_valid }
  it { should belong_to(:consultant) }
  it { should belong_to(:user) }

  describe 'association' do
    describe 'consultant' do
      before do
        subject.save!
      end

      it 'should not be destroyed on delete' do
        consultant_id = subject.consultant_id

        subject.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'user' do
      before do
        subject.save!
      end

      it 'should not be destroyed on delete' do
        user_id = subject.user_id

        subject.destroy
        expect(User.find_by_id(user_id)).not_to be_nil
      end
    end
  end
end
