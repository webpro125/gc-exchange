require 'spec_helper'

describe Phone do
  before do
    @type = FactoryGirl.create(:phone_type)
    @phone = Phone.new(number: '1238675309', phone_type: @type, phoneable_id: 1,
                       phoneable_type: 'Consultant')
  end

  subject { @phone }

  it { should be_valid }

  describe 'number' do
    it 'should format the number' do
      expect(@phone.number).to_not eq('123 867 5309')
      @phone.valid?
      expect(@phone.number).to eq('123-867-5309')
    end

    it 'should not accept text' do
      @phone.number = 'test'
      expect(@phone).to_not be_valid
    end
  end

  describe 'phoneable' do
    it 'phoneable_id is required' do
      @phone.phoneable_id = nil
      expect(@phone).to_not be_valid
    end

    it 'phoneable_type is required' do
      @phone.phoneable_type = nil
      expect(@phone).to_not be_valid
    end
  end

  describe 'associations' do
    describe 'phone_type' do
      it 'should not be destroyed' do
        id = @type.id
        @phone.destroy
        expect(PhoneType.find_by_id(id)).not_to be_nil
      end
    end
  end
end
