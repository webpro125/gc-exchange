require 'spec_helper'

describe User do
  let(:company) { FactoryGirl.attributes_for(:company) }

  subject do
    user = User.new(first_name: 'Freddy II',
                    last_name: 'Kreuger',
                    email: 'freddy2.kreuger@globalconsultantexchange.com'
    )
    user.build_owned_company(company)
    user
  end

  it { should be_valid }

  describe 'first_name' do
    it { expect(subject).to validate_presence_of(:first_name) }
    it { should ensure_length_of(:first_name).is_at_least(2) }
    it { should ensure_length_of(:first_name).is_at_most(24) }
    it { expect(subject).to allow_value('james').for(:first_name) }
    it { expect(subject).to allow_value('billy-jean 2').for(:first_name) }
    it { expect(subject).to_not allow_value('1234567').for(:first_name) }
    it { expect(subject).to_not allow_value('!@#$').for(:first_name) }
  end

  describe 'last_name' do
    it { expect(subject).to validate_presence_of(:last_name) }
    it { should ensure_length_of(:last_name).is_at_least(2) }
    it { should ensure_length_of(:last_name).is_at_most(24) }
    it { expect(subject).to allow_value('John 123567').for(:last_name) }
    it { expect(subject).to_not allow_value('!@#$').for(:last_name) }
  end

  describe 'email' do
    it { expect(subject).to validate_presence_of(:email) }
  end

  describe 'gces?' do
    it 'returns false' do
      subject.owned_company = nil
      subject.company = FactoryGirl.build(:company)
      expect(subject.gces?).to eq false
    end

    it 'returns true' do
      subject.owned_company = nil
      subject.company = Company.new(company_name: Company::GLOBAL_CONSULTANT_EXCHANGE)
      expect(subject.gces?).to eq true
    end
  end

  describe 'associations' do
    before do
      subject.save
    end

    it { expect(subject).to belong_to(:company) }
    it { expect(subject).to have_one(:owned_company) }

    describe 'company' do
      before do
        subject.company.users << FactoryGirl.build_list(:user, 3)
      end

      describe 'as user' do
        it 'should not delete company on destroy' do
          company_id = subject.company_id
          user = subject.company.users.last
          user.destroy
          expect(Company.find(company_id)).not_to be_nil
        end
      end
    end

    describe 'as owner' do
      it 'should not be deleted' do
        expect { subject.destroy }.not_to change { User.count }
      end
    end
  end
end
