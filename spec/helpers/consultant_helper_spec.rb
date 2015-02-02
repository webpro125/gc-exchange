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

    describe '#consultant_owns_record?' do
      let(:consultant) { FactoryGirl.create(:consultant, :approved) }

      before do
        helper.instance_variable_set('@consultant', consultant)
      end

      it 'should return true' do
        helper.stub_chain(:current_consultant).and_return(consultant)
        expect(helper.consultant_owns_record?(consultant)).to eq true
      end

      it 'should return false' do
        helper.stub_chain(:current_consultant).and_return(
          FactoryGirl.create(:consultant, :approved))
        expect(helper.consultant_owns_record?(consultant)).to eq false
      end
    end
  end
end
