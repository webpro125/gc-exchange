require 'spec_helper'
require 'user'
require 'consultant'

describe ConsultantHelper do

  describe 'logged in' do
    describe 'as GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }
      let(:consultant) { FactoryGirl.create(:consultant, :approved) }

      it 'should return true' do
        allow(helper).to receive(:current_user)  { true }
        helper.stub(:user_is_gces?).and_return(true)
        expect(helper.user_is_gces?).to eq true
      end

      it 'should return true' do
        allow(helper).to receive(:current_consultant)  { true }
        helper.stub(:consultant_owns_record?).and_return(true)
        expect(helper.consultant_owns_record?).to eq true
      end
    end
  end
end
