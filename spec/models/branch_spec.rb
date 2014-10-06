require 'spec_helper'

describe Branch do
  it_behaves_like 'lookup'

  subject { Branch.new(code: 'MY_BRANCH') }

  it { should be_valid }
end
