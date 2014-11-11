require 'spec_helper'

describe PhoneType do
  it_behaves_like 'lookup'

  subject { PhoneType.new(code: 'MY_PHONE_TYPE', label: 'my phone') }

  it { should be_valid }
end
