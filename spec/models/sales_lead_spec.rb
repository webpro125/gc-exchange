require 'spec_helper'

describe SalesLead do
  subject do
    SalesLead.new(
      first_name: 'FirstName',
      last_name: 'LastName',
      company_name: 'Company Name',
      message: 'I am really interested in joining this awesome site!',
      email: 'test@test.com',
      phone_number: '123-123-1321'
    )
  end

  it { should be_valid }

  describe 'first_name' do
    it { should ensure_length_of(:first_name).is_at_least(2) }
    it { should ensure_length_of(:first_name).is_at_most(24) }
  end

  describe 'last_name' do
    it { should ensure_length_of(:last_name).is_at_least(2) }
    it { should ensure_length_of(:last_name).is_at_most(24) }
  end

  describe 'company_name' do
    it { should ensure_length_of(:company_name).is_at_least(2) }
    it { should ensure_length_of(:company_name).is_at_most(128) }
  end

  describe 'message' do
    it { should ensure_length_of(:message).is_at_least(2) }
    it { should ensure_length_of(:message).is_at_most(5_000) }
  end
end
