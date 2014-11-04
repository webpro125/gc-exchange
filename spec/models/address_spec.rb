require 'spec_helper'

describe Address do
  it_behaves_like 'indexable', :address=, '1620 3rd Ave New York, NY 10128'

  let(:address) do
    Address.new(
      consultant: FactoryGirl.create(:confirmed_consultant, :approved),
      address: '1619 3rd Ave New York, NY 10128'
    )
  end

  subject { address }

  it { should be_valid }

  describe 'consultant' do
    it 'should be present' do
      subject.consultant = nil
      expect(subject).not_to be_valid
    end

    it 'should be eq to lon' do
      subject.save
      expect(subject.lon).to eq(subject.longitude)
    end
  end

  describe 'latitude' do
    it 'should set latitude on validation' do
      expect(subject.latitude).to be_nil
      subject.valid?
      expect(subject.latitude).to_not be_nil
    end

    it 'should be eq to lat' do
      subject.save
      expect(subject.lat).to eq(subject.latitude)
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
    let(:invalid) do
      Address.new(
        consultant: FactoryGirl.create(:confirmed_consultant),
        address: Geocoder::Lookup::Test::INVALID_ADDRESS
      )
    end

    it 'should be invalid' do
      expect(invalid).not_to be_valid
    end

    it 'should correctly throw geocode error' do
      translation = 'activerecord.errors.models.address.attributes.geocode_fail'
      invalid.valid?
      expect(invalid.errors[:address]).to include(I18n.t(translation))
    end
  end
end
