require 'spec_helper'

describe Entity do
  let(:entity){ FactoryGirl.build(:entity) }

  subject { entity }

  it { expect(subject).to belong_to(:consultant)}
end
