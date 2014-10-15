require 'spec_helper'

describe Company do
  let(:owner) { FactoryGirl.build(:user) }
  subject do
    Company.new(company_name: 'My Test Company', company_owner: owner)
  end

  it { should be_valid }

  describe 'company_name' do
    it 'should have a minimum length' do
      subject.company_name = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have a maximum length' do
      subject.company_name = 'a' * 129
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.company_name = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'company_owner_id' do
    it 'should be present' do
      subject.company_owner = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    before do
      subject.save!
    end

    it 'should not delete users' do
      user_id = subject.users.pluck(:id)
      subject.destroy
      user_id.each do |id|
        expect(User.find_by_id(id)).not_to be_nil
      end
    end
  end
end
