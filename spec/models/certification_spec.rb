require 'spec_helper'

describe Certification do
  it_behaves_like 'lookup'

  subject { Certification.new(code: 'NEW_CERT') }

  it { should be_valid }
end
