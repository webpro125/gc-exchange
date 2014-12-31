require 'spec_helper'

describe Rank do
  it_behaves_like 'lookup'

  subject { Rank.new(code: 'MY_RANK', label: 'my rank') }

  it { should be_valid }
end
