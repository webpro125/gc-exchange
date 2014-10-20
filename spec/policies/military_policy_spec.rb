require 'spec_helper'

describe MilitaryPolicy do
  subject { MilitaryPolicy.new(consultant, military) }

  describe 'for a user' do
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    describe 'for valid military' do
      let(:military) { FactoryGirl.create(:military, consultant: consultant) }

      it { should permit_action(:create)  }
      it { should permit_action(:update)  }

      it { should_not permit_action(:new)     }
      it { should_not permit_action(:index)   }
      it { should_not permit_action(:destroy) }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:show)    }

    end
  end

  describe 'for a visitor' do
    let(:military) { FactoryGirl.create(:military) }
    let(:consultant) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
