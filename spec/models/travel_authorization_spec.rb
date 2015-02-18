require 'spec_helper'

describe TravelAuthorization do
  it_behaves_like 'lookup'

  subject { TravelAuthorization.new(code: 'TRAVEL_AUTH', label: 'Travel Authorized') }

  it { should be_valid }
end
