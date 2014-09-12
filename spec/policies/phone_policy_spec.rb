require 'spec_helper'

describe PhonePolicy do
  subject { PhonePolicy.new(consultant, phone) }

  let(:phone) { FactoryGirl.create(:phone, phoneable: consultant) }

  describe 'for a user' do
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    it { should permit_action(:show)    }
    it { should permit_action(:create)  }
    it { should permit_action(:new)     }
    it { should permit_action(:update)  }
    it { should permit_action(:edit)    }
    it { should permit_action(:destroy) }
  end

  describe 'for a visitor' do
    let(:consultant) { nil }

    it 'raises an error' do
      expect { permit_action(:show) }.to_not raise_error
    end
  end
end
