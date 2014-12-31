require 'spec_helper'

describe PhonePolicy do
  subject { PhonePolicy.new(consultant, phone) }

  describe 'for a user' do
    let(:phone) { FactoryGirl.create(:phone, phoneable: consultant) }
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    it { should permit_action(:show)    }
    it { should permit_action(:create)  }
    it { should permit_action(:new)     }
    it { should permit_action(:update)  }
    it { should permit_action(:edit)    }
    it { should permit_action(:destroy) }
  end

  describe 'for a visitor' do
    let(:phone) { FactoryGirl.create(:phone) }
    let(:consultant) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
