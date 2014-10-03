require 'spec_helper'

describe Rank do
  it_behaves_like 'lookup'

  subject { Rank.new(code: 'MY_RANK') }

  it { should be_valid }
end
