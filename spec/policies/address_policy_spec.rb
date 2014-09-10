require 'spec_helper'

describe AddressPolicy do
  subject { AddressPolicy.new(consultant, address) }

  let(:address) { FactoryGirl.create(:address, consultant: consultant) }

  describe 'for a user' do
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    it { should         permit(:show)    }
    it { should         permit(:create)  }
    it { should         permit(:new)     }
    it { should         permit(:update)  }
    it { should         permit(:edit)    }
    it { should_not     permit(:destroy) }
  end

  describe 'for a visitor' do
    let(:consultant) { nil }

    it 'raises an error' do
      expect { permit(:show) }.to_not raise_error
    end
  end
end
