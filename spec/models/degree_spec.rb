require 'spec_helper'

describe Degree do
  it_behaves_like 'lookup'

  subject { Degree.new(code: 'MY_DEGREE', label: 'get on my degree') }

  it { should be_valid }
end
