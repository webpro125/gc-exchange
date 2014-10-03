require 'spec_helper'

describe Discipline do
  it_behaves_like 'lookup'

  subject { Discipline.new(code: 'MY_DISCIPLINE') }

  it { should be_valid }
end
