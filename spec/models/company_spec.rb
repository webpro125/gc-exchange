require 'spec_helper'

describe Company do
  let(:owner) { FactoryGirl.build(:user) }

  subject do
    Company.new(company_name: 'My Test Company', owner: owner)
  end

  it { should be_valid }

  describe 'company_name' do
    it { expect(subject).to validate_presence_of(:company_name) }
    it { should ensure_length_of(:company_name).is_at_least(2) }
    it { should ensure_length_of(:company_name).is_at_most(512) }
  end

  describe 'owner' do
    it { expect(subject).to validate_presence_of(:owner) }
  end

  describe 'associations' do
    before do
      subject.users << FactoryGirl.build_list(:user, 5)
      subject.save
    end

    it { expect(subject).to belong_to(:owner) }
    it { expect(subject).to have_many(:users) }

    it 'should delete users' do
      user_ids = subject.users.pluck(:id)
      subject.destroy

      user_ids.each do |id|
        expect(User.find_by_id(id)).to be_nil
      end
    end
  end
end
