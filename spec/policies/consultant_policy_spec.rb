require 'spec_helper'
require 'byebug'

describe ConsultantPolicy do
  subject { ConsultantPolicy.new(user, user.consultant) }

  describe 'approved consultant' do
    # let(:consultant) { FactoryGirl.create(:consultant, :approved) }
    # let(:user) { FactoryGirl.create(:user, :approved) }
    describe 'as owner' do
      let(:user) { FactoryGirl.build(:user, :as_owner, :approved) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
      it { should_not permit_action(:contract) }
      it { should permit_action(:show) }
    end

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user, :approved) }

      it { should permit_action(:index)  }
      it { should permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:contract) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
      it { should_not permit_action(:approve) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company, :approved) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
      it { should_not permit_action(:contract) }
      it { should permit_action(:show) }
    end

    describe 'for a visitor' do
      let(:user) { nil }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
      it { should_not permit_action(:contract) }
      it { should permit_action(:show) }
    end

    describe 'for the consultant' do
      # let(:user) { consultant }
      let(:user) { FactoryGirl.create(:user, :wicked_finish) }
      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end
  end

end
