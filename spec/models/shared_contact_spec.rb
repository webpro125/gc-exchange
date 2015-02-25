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

end
