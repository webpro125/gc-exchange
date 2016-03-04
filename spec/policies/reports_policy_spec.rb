require 'spec_helper'

describe ReportPolicy do
  subject { ReportPolicy.new(user, :report) }

  describe 'for a user' do
    let(:user) { FactoryGirl.create(:gces_user) }

    describe 'for GCES admin' do
      it { should permit_action(:index)  }
    end
  end

  describe 'for a visitor' do
    let(:user) { nil }

    it { should_not permit_action(:index) }
  end

  describe 'for a consultant' do
    let(:user) { FactoryGirl.create(:consultant) }

    it { should_not permit_action(:index) }
  end

  describe 'for a user not gces' do
    let(:user) { FactoryGirl.create(:user, :with_company) }

    it { should_not permit_action(:index) }
  end
end
