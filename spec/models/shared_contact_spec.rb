require 'spec_helper'

describe SharedContact do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  subject do
    SharedContact.new(
      consultant:            consultant,
      user:                        user,
      allowed:                     true
    )
  end

  it { should be_valid }
  it { expect(subject).to validate_presence_of(:consultant) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:allowed) }

end
