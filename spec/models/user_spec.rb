require 'spec_helper'

describe User do
  let(:company) { FactoryGirl.build(:company) }

  subject do
    User.new(first_name: 'Freddy II',
             last_name: 'Kreuger',
             email: 'freddy2.kreuger@globalconsultantexchange.com',
             password: 'password',
             password_confirmation: 'password')
  end

  it { should be_valid }

  describe 'first_name' do
    it 'should have minimum length' do
      subject.first_name = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.first_name = 'a' * 25
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.first_name = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only characters numbers and hyphens' do
      subject.first_name = 'james'
      expect(subject).to be_valid

      subject.first_name = 'billy-jean 2'
      expect(subject).not_to be_valid

      subject.first_name = '123567'
      expect(subject).not_to be_valid

      subject.first_name = '!@#$'
      expect(subject).not_to be_valid
    end
  end

  describe 'last_name' do
    it 'should have minimum length' do
      subject.last_name = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.last_name = 'a' * 25
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.last_name = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only characters and numbers' do
      subject.last_name = 'John 123567'
      expect(subject).to be_valid

      subject.last_name = '!@#$'
      expect(subject).not_to be_valid
    end
  end

  describe 'email' do
    it 'should be present' do
      subject.email = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'associations' do
    describe 'companies' do
      before do
        company_user = FactoryGirl.create(:user, :as_part_of_company, company: company)
      end

      it 'should not delete companies on destroy' do
        company_id = subject
        subject.destroy
        expect(Company.find(company_id)).not_to be_nil
      end

      #   it 'should delete user groups' do
      #     group_id = @user.user_groups.first.id
      #     @user.destroy
      #     expect(UserGroup.find_by_id(group_id)).to be_nil
      #   end
    end
  end
end
