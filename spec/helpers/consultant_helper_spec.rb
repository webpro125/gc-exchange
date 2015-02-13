require 'spec_helper'

describe ConsultantHelper do

  describe 'logged in' do
    describe '#user_is_gces?' do
      it 'should return true' do
        helper.stub_chain(:current_user, :gces?).and_return(true)
        expect(helper.user_is_gces?).to eq true
      end

      it 'should return false' do
        helper.stub_chain(:current_user, :gces?).and_return(false)
        expect(helper.user_is_gces?).to eq false
      end
    end
  end
end
