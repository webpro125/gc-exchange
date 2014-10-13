require 'spec_helper'

describe Search do
  subject { Search.new(params) }

  describe 'no values' do
    let(:params) { {} }

    it { should be_invalid }
  end

  describe 'just address' do
    let(:params) { { address: 'New York City' } }

    it { should be_invalid }
  end

  describe 'just distance' do
    let(:params) { { distance: 30 } }

    it { should be_invalid }
  end

  describe 'one field' do
    let(:params) { { clearance_active: true } }

    it { should be_valid }
  end
end
