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
      @consultant.first_name = '123567'
      expect(@consultant).to be_valid

      @consultant.first_name = 'james'
      expect(@consultant).to be_valid

      @consultant.first_name = 'billy-jean 2'
      expect(@consultant).to be_valid

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
end
