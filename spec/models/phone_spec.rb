require 'spec_helper'

describe Phone do
  before do
    @type = FactoryGirl.create(:phone_type)
    @phone = Phone.new(number: '1238675309', ext: '112', phone_type: @type, phoneable_id: 1,
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
  end

  describe "number_with_ext" do
    it 'allows an extension' do
      @phone.valid?
      expect(@phone.number_with_ext).to eq('123-867-5309 Ext: 112')
    end

    it 'is ok for ext to be blank' do
      @phone.ext = nil
      @phone.valid?
      expect(@phone.number_with_ext).to eq('123-867-5309')
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
