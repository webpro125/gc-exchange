require 'spec_helper'

describe Consultant do
  before do
    @consultant = Consultant.new(
        first_name: 'Freddy',
        last_name: 'Kreuger',
        email: 'freddy.kreuger@globalconsultantexchange.com',
        password: 'password',
        password_confirmation: 'password'
    )
  end

  subject { @consultant }

  it { should be_valid }
  it { should respond_to(:phones) }

  describe 'first_name' do
    it 'should have minimum length' do
      @consultant.first_name = 'a' * 2
      expect(@consultant).not_to be_valid
    end

    it 'should have maximum length' do
      @consultant.first_name = 'a' * 25
      expect(@consultant).not_to be_valid
    end

    it 'should be present' do
      @consultant.first_name = nil
      expect(@consultant).not_to be_valid
    end

    it 'should allow only characters numbers and hyphens' do
      @consultant.first_name = 'james'
      expect(@consultant).to be_valid

      @consultant.first_name = 'billy-jean 2'
      expect(@consultant).not_to be_valid

      @consultant.first_name = '123567'
      expect(@consultant).not_to be_valid

      @consultant.first_name = '!@#$'
      expect(@consultant).not_to be_valid
    end
  end

  describe 'last_name' do
    it 'should have minimum length' do
      @consultant.last_name = 'a' * 2
      expect(@consultant).not_to be_valid
    end

    it 'should have maximum length' do
      @consultant.last_name = 'a' * 25
      expect(@consultant).not_to be_valid
    end

    it 'should be present' do
      @consultant.last_name = nil
      expect(@consultant).not_to be_valid
    end

    it 'should allow only characters and numbers' do
      @consultant.last_name = 'John 123567'
      expect(@consultant).to be_valid

      @consultant.last_name = '!@#$'
      expect(@consultant).not_to be_valid
    end
  end

  describe 'association' do
    describe 'address' do
      before do
        @consultant.save!
        FactoryGirl.create(:address, consultant: @consultant)
      end

      it 'should be destroyed on delete' do
        address = @consultant.address.id
        expect(address).not_to be_nil

        @consultant.destroy
        expect(Address.find_by_id(address)).to be_nil
      end
    end

    describe 'phones' do
      before do
        @consultant.phones << FactoryGirl.create(:phone)
        @consultant.save!
      end

      it 'should destroy them on delete' do
        phones = @consultant.phones.map(&:id)
        expect(phones).not_to be_nil

        @consultant.destroy
        phones.each do |phone|
          expect(Phone.find_by_id(phone)).to be_nil
        end
      end

      it 'should not allow more than 3' do
        @consultant.phones << FactoryGirl.build_list(:phone, 3)
        expect(@consultant).not_to be_valid
      end
    end

    describe 'skills' do
      before do
        @consultant.skills << FactoryGirl.create(:skill)
        @consultant.save!
      end

      it 'should not destroy them on delete' do
        skills = @consultant.skills.map(&:id)
        expect(skills).not_to be_nil

        @consultant.destroy
        skills.each do |skill|
          expect(Skill.find_by_id(skill)).not_to be_nil
        end
      end
    end

    describe 'consultant_skills' do
      before do
        @consultant.skills << FactoryGirl.create(:skill)
        @consultant.save!
      end

      it 'should destroy them on delete' do
        id = @consultant.id
        skills = @consultant.skills.map(&:id)

        @consultant.destroy
        skills.each do |skill|
          expect(ConsultantSkill.find_by(consultant_id: id, skill_id: skill)).to be_nil
        end
      end
    end
  end
end
