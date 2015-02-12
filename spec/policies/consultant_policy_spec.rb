require 'spec_helper'

describe ConsultantPolicy do
  subject { ConsultantPolicy.new(user, consultant) }

  describe 'approved consultant' do
    let(:consultant) { FactoryGirl.create(:consultant, :approved) }

    describe 'as owner' do
      let(:user) { FactoryGirl.build(:user, :as_owner) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
      it { should permit_action(:show) }
    end

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      it { should permit_action(:index)  }
      it { should permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
      it { should_not permit_action(:approve) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
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
      it { should permit_action(:show) }
    end

    describe 'for the consultant' do
      let(:user) { consultant }

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

  describe 'pending_approval consultant' do
    let(:consultant) { FactoryGirl.create(:consultant, :pending_approval) }

    describe 'as owner' do
      let(:user) { FactoryGirl.build(:user, :as_owner) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
      it { should permit_action(:show) }
    end

    describe 'for the consultant' do
      let(:user) { consultant }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      it { should permit_action(:index)  }
      it { should permit_action(:approve) }
      it { should permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
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
      it { should permit_action(:show) }
    end
  end

  describe 'rejected consultant' do
    let(:consultant) { FactoryGirl.create(:consultant, :rejected) }

    describe 'as owner' do
      let(:user) { FactoryGirl.build(:user, :as_owner) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:show) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end

    describe 'for the consultant' do
      let(:user) { consultant }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      it { should permit_action(:index)  }
      it { should permit_action(:approve) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
      it { should_not permit_action(:reject) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:show) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end

    describe 'for a visitor' do
      let(:user) { nil }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:show) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end
  end

  describe 'in_progress consultant' do
    let(:consultant) { FactoryGirl.create(:consultant, :in_progress) }

    describe 'as owner' do
      let(:user) { FactoryGirl.build(:user, :as_owner) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:show) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end

    describe 'for the consultant' do
      let(:user) { consultant }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      it { should permit_action(:index)  }
      it { should permit_action(:edit) }
      it { should permit_action(:update) }
      it { should permit_action(:show) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:show) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end

    describe 'for a visitor' do
      let(:user) { nil }

      it { should_not permit_action(:index)  }
      it { should_not permit_action(:approve) }
      it { should_not permit_action(:reject) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:show) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end
  end
end
