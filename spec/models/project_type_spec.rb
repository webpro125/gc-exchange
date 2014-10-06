require 'spec_helper'

describe ProjectType do
  it_behaves_like 'lookup'

  subject { ProjectType.new(code: 'MY_PROJECT_TYPE') }

  it { should be_valid }
end
