require 'spec_helper'

describe Address do
  before do
    @consultant = FactoryGirl.create(:confirmed_consultant)

    @address = Address.new(
        address1: '1619 3rd Ave',
        city: 'New York',
        state: 'NY',
        zipcode: '10128',
        addressable: @consultant
    )
  end

  subject { @address }

  it { should be_valid }

  describe 'address1' do
    it 'should have a minimum length' do
      @address.address1 = 'a' * 3
      expect(@address).not_to be_valid
    end

    it 'should have a maximum length' do
      @address.address1 = 'a' * 129
      expect(@address).not_to be_valid
    end

    it 'should be present' do
      @address.address1 = nil
      expect(@address).not_to be_valid
    end
  end

  describe 'address2' do
    it 'should have a minimum length' do
      @address.address2 = 'a' * 3
      expect(@address).not_to be_valid
    end

    it 'should have a maximum length' do
      @address.address2 = 'a' * 129
      expect(@address).not_to be_valid
    end

    it 'can be nil' do
      @address.address2 = nil
      expect(@address).to be_valid
    end
  end

  describe 'city' do
    it 'should have a minimum length' do
      @address.city = 'a' * 2
      expect(@address).not_to be_valid
    end

    it 'should have a maximum length' do
      @address.city = 'a' * 65
      expect(@address).not_to be_valid
    end

    it 'should be present' do
      @address.city = nil
      expect(@address).not_to be_valid
    end

    it 'should only contain letters with spaces' do
      input = %w(12as b2# !4 @.#)
      input.each do |i|
        @address.city = i
        expect(@address).not_to be_valid
      end

      input = ['New York']
      input.each do |i|
        @address.city = i
        expect(@address).to be_valid
      end
    end
  end

  describe 'state' do
    it 'should have a minimum length' do
      @address.state = 'a' * 1
      expect(@address).not_to be_valid
    end

    it 'should have a maximum length' do
      @address.state = 'a' * 3
      expect(@address).not_to be_valid
    end

    it 'should be present' do
      @address.state = nil
      expect(@address).not_to be_valid
    end

    it 'should only contain valid states' do
      @address.state = 'ZZ'
      expect(@address).not_to be_valid
    end
  end

  describe 'zipcode' do
    it 'should have a minimum length' do
      @address.zipcode = '1' * 4
      expect(@address).not_to be_valid
    end

    it 'should have a maximum length' do
      @address.zipcode = '1' * 6
      expect(@address).not_to be_valid
    end

    it 'should be present' do
      @address.zipcode = nil
      expect(@address).not_to be_valid
    end

    it 'should only contain numbers' do
      input = %w(asdfg !@#$% A1234 !se32)
      input.each do |i|
        @address.zipcode = i
        expect(@address).not_to be_valid
      end
    end
  end

  describe 'consultant' do
    it 'should be present' do
      @address.consultant = nil
      expect(@address).not_to be_valid
    end
  end

  describe 'latitude' do
    it 'should set latitude on validation' do
      expect(@address.latitude).to be_nil
      @address.valid?
      expect(@address.latitude).to_not be_nil
    end
  end

  describe 'longitude' do
    it 'should set longutude on validation' do
      expect(@address.longitude).to be_nil
      @address.valid?
      expect(@address.longitude).to_not be_nil
    end
  end
end
