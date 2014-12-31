require 'spec_helper'

describe AddressPolicy do
  subject { AddressPolicy.new(consultant, address) }

  describe 'for a user' do
    let(:address) { FactoryGirl.create(:address, consultant: consultant) }
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    it { should permit_action(:show)    }
    it { should permit_action(:create)  }
    it { should permit_action(:new)     }
    it { should permit_action(:update)  }
    it { should permit_action(:edit)    }

    it { should_not permit_action(:destroy) }
  end

  describe 'for a visitor' do
    let(:address) { FactoryGirl.create(:address) }
    let(:consultant) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
