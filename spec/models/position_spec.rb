require 'spec_helper'

describe Position do
  it_behaves_like 'lookup'

  subject { Position.new(code: 'MY_POSITION', label: 'my position') }

  it { should be_valid }
end
