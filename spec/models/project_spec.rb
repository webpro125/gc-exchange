require 'spec_helper'

describe Project do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  subject do
    Project.new(
      consultant: consultant,
      user: user,
      travel_authorization: TravelAuthorization.first
    )
  end

  it { expect(subject).to be_valid }

  it { expect(subject).to belong_to(:consultant) }
  it { expect(subject).to belong_to(:user) }

  it { expect(subject).to validate_presence_of(:user) }

  it { expect(subject).to validate_presence_of(:consultant) }
  # it { expect(subject).to validate_uniqueness_of(:consultant) } TODO

  it { expect(subject).to validate_presence_of(:travel_authorization) }
end
