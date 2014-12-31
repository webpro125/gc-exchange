require 'spec_helper'

describe ClearanceLevel do
  it_behaves_like 'lookup'

  subject { ClearanceLevel.new(code: 'MY_LEVEL', label: 'my level') }

  it { should be_valid }
end
