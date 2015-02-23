require 'spec_helper'

describe ProjectPolicy do
  describe 'for a user' do
    subject { ProjectPolicy.new(user, project) }
    let(:user) { FactoryGirl.create(:user, :with_company) }

    describe 'for valid project' do
      let(:project) { FactoryGirl.create(:project, user: user) }

      it { should permit_action(:create) }
      it { should permit_action(:new) }
      it { should permit_action(:update) }
      it { should permit_action(:edit) }
      it { should permit_action(:show) }
      it { should_not permit_action(:destroy) }
    end

    describe 'for another project' do
      let(:project) { FactoryGirl.create(:project) }

      it { should_not permit_action(:show) }
      it { should_not permit_action(:create) }
      it { should_not permit_action(:new) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:destroy) }
    end
  end

  describe 'for a user' do
    subject { ProjectPolicy.new(consultant, project) }
    let(:consultant) { FactoryGirl.create(:consultant) }

    describe 'for valid project' do
      let(:project) { FactoryGirl.create(:project, consultant: consultant) }

      it { should permit_action(:show) }
      it { should_not permit_action(:create) }
      it { should_not permit_action(:new) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:destroy) }
    end

    describe 'for another project' do
      let(:project) { FactoryGirl.create(:project) }

      it { should_not permit_action(:show) }
      it { should_not permit_action(:create) }
      it { should_not permit_action(:new) }
      it { should_not permit_action(:update) }
      it { should_not permit_action(:edit) }
      it { should_not permit_action(:destroy) }
    end
  end

  describe 'for a visitor' do
    subject { ProjectPolicy.new(consultant, project) }
    let(:consultant) { nil }

    it ' raises an error ' do
      expect { subject }.to raise_error
    end
  end
end
