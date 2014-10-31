require 'spec_helper'

describe PhoneUnsetPrimaries do
  subject { PhoneUnsetPrimaries.new(phone) }

  describe 'with valid phone' do
    let(:phone) { FactoryGirl.create(:phone, primary: true) }

    it 'should return true on save' do
      expect(subject).to receive(:save).and_return(true)
      subject.save
    end
  end

  describe 'with invalid phone' do
    let(:phone) { FactoryGirl.create(:phone, primary: false) }

    it 'should return false on save' do
      phone.number = nil
      expect(subject).to receive(:save).and_return(false)
      subject.save
    end
  end

  describe 'with primary' do
    let(:phone) { FactoryGirl.create(:phone, primary: true) }

    it 'should set other phones not primary' do
      expect(phone).to receive(:save!)
      subject.save
    end
  end

  describe 'without primary' do
    let(:phone) { FactoryGirl.create(:phone, primary: false) }

    it 'should set other phones not primary' do
      Phone.any_instance.should_not_receive(:update)
      subject.save
    end
  end
end
