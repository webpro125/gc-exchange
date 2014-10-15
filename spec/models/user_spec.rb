require 'spec_helper'

describe User do
  let(:company) { FactoryGirl.attributes_for(:company) }

  subject do
    user = User.new(first_name: 'Freddy II',
                    last_name: 'Kreuger',
                    email: 'freddy2.kreuger@globalconsultantexchange.com',
                    password: 'password',
                    password_confirmation: 'password'
    )
    user.build_owned_company(company)
    user
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
    before do
      subject.save!
    end

    describe 'company' do
      before do
        subject.company.users << FactoryGirl.build_list(:user, 3)
      end

      it 'should not delete company on destroy' do
        company_id = subject.company_id
        user = subject.company.users.last
        user.destroy
        expect(Company.find(company_id)).not_to be_nil
      end
    end

    describe 'as owner' do
      it 'should not be deleted' do
        expect { subject.destroy }.not_to change { User.count }
      end
    end
  end
end
