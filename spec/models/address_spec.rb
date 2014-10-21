require 'spec_helper'

describe Address do
  it_behaves_like 'indexable', :address1=, '1620 3rd Ave'

  let(:address) do
    Address.new(
        consultant: FactoryGirl.create(:confirmed_consultant, :approved),
        address1: '1619 3rd Ave',
        city: 'New York',
        state: 'NY',
        zipcode: '10128'
    )
  end

  subject { address }

  it { should be_valid }

  describe 'address1' do
    it 'should have a minimum length' do
      subject.address1 = 'a' * 3
      expect(subject).not_to be_valid
    end

    it 'should have a maximum length' do
      subject.address1 = 'a' * 129
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.address1 = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'address2' do
    it 'should have a minimum length' do
      subject.address2 = 'a' * 3
      expect(subject).not_to be_valid
    end

    it 'should have a maximum length' do
      subject.address2 = 'a' * 129
      expect(subject).not_to be_valid
    end

    it 'can be nil' do
      subject.address2 = nil
      expect(subject).to be_valid
    end
  end

  describe 'city' do
    it 'should have a minimum length' do
      subject.city = 'a' * 2
      expect(subject).not_to be_valid
    end

    it 'should have a maximum length' do
      subject.city = 'a' * 65
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.city = nil
      expect(subject).not_to be_valid
    end

    it 'should only contain letters with spaces' do
      input = %w(12as b2# !4 @.#)
      input.each do |i|
        subject.city = i
        expect(subject).not_to be_valid
      end

      input = ['New York']
      input.each do |i|
        subject.city = i
        expect(subject).to be_valid
      end
    end
  end

  describe 'state' do
    it 'should have a minimum length' do
      subject.state = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have a maximum length' do
      subject.state = 'a' * 3
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.state = nil
      expect(subject).not_to be_valid
    end

    it 'should only contain valid states' do
      subject.state = 'ZZ'
      expect(subject).not_to be_valid
    end
  end

  describe 'zipcode' do
    it 'should have a minimum length' do
      subject.zipcode = '1' * 4
      expect(subject).not_to be_valid
    end

    it 'should have a maximum length' do
      subject.zipcode = '1' * 6
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.zipcode = nil
      expect(subject).not_to be_valid
    end

    it 'should only contain numbers' do
      input = %w(asdfg !@#$% A1234 !se32)
      input.each do |i|
        subject.zipcode = i
        expect(subject).not_to be_valid
      end
    end
  end

  describe 'consultant' do
    it 'should be present' do
      subject.consultant = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'latitude' do
    it 'should set latitude on validation' do
      expect(subject.latitude).to be_nil
      subject.valid?
      expect(subject.latitude).to_not be_nil
    end
  end

  describe 'longitude' do
    it 'should set longutude on validation' do
      expect(subject.longitude).to be_nil
      subject.valid?
      expect(subject.longitude).to_not be_nil
    end
  end

  describe 'invalid address' do
    let(:invalid_address) do
      Address.new(
          consultant: FactoryGirl.create(:confirmed_consultant),
          address1: 'oaiwjevoiajwefaw',
          city: 'bjbjbj',
          state: 'AZ',
          zipcode: '99999'
        )
    end

    it 'should be invalid' do
      current = invalid_address
      current.valid?
      expect(current).not_to be_valid
    end

    it 'should correctly throw geocode error' do
      current = invalid_address
      current.valid?
      expect(current.errors['address1']).to include(I18n.t(
        'activerecord.errors.models.address.attributes.geocode_fail'))
    end
  end
end
