require 'spec_helper'

describe Phone do
  before do
    @type = FactoryGirl.create(:phone_type)
    @phone = Phone.new(number: '8675309', phone_type: @type)
  end

  subject { @phone }

  it { should be_valid }

  describe 'number' do
    it 'is required' do
      @phone.number = nil
      expect(@phone).to_not be_valid
    end

    it 'should format the number' do
      expect(@phone.number).to_not eq('867 5309')
      @phone.valid?
      expect(@phone.number).to eq('867-5309')
    end
  end

  describe 'associations' do
    describe 'phone_type' do
      it 'is required' do
        @phone.phone_type = nil
        expect(@phone).to_not be_valid
      end

      it 'should not be destroyed' do
        id = @type.id
        @phone.destroy
        expect(PhoneType.find_by_id(id)).not_to be_nil
      end
    end
  end
end
