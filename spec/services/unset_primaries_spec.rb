require 'spec_helper'

describe UnsetPrimaries do
  subject { UnsetPrimaries.new(phone) }

  describe 'with primary' do
    let(:phone) { FactoryGirl.create(:phone, primary: true) }
    it 'should set other phones not primary' do
      Phone.any_instance.should_receive(:save).and_return(true)
      subject.save
    end
  end

  describe 'without primary' do
    let(:phone) { FactoryGirl.create(:phone, primary: false) }
    it 'should set other phones not primary' do
      Phone.any_instance.should_not_receive(:save).and_return(true)
      subject.save
    end
  end
end
