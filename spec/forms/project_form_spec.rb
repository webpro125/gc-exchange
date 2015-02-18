require 'spec_helper'

describe ProjectForm do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  subject do
    ProjectForm.new(
      Project.new(
        consultant:           consultant,
        user:                 user,
        travel_authorization: TravelAuthorization.first,
        proposed_start:       1.month.from_now,
        proposed_end:         2.months.from_now,
        project_name:         'Test project',
        project_location:     'New York City',
        proposed_rate:        100.00))
  end

  it { should be_valid }

  it { expect(subject).to validate_presence_of(:travel_authorization_id) }

  it { expect(subject).to validate_presence_of(:proposed_start) }

  it { expect(subject).to validate_presence_of(:proposed_end) }

  it { expect(subject).to validate_presence_of(:project_name) }
  it { expect(subject).to ensure_length_of(:project_name).is_at_least(2).is_at_most(128) }

  it { expect(subject).to validate_presence_of(:project_location) }
  it { expect(subject).to ensure_length_of(:project_location).is_at_least(2).is_at_most(500) }

  it { expect(subject).to validate_presence_of(:proposed_rate) }
  it do
    expect(subject).to(
      validate_numericality_of(:proposed_rate).is_greater_than(0).is_less_than_or_equal_to(5_000))
  end
end
