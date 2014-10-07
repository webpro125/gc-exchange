require 'spec_helper'

describe CustomerName do
  it_behaves_like 'lookup'

  subject { CustomerName.new(code: 'MY_CUSTOMER') }

  it { should be_valid }
end
