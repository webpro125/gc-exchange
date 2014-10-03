require 'spec_helper'

describe MilitaryPolicy do
  subject { MilitaryPolicy.new(consultant, military) }

  describe 'for a user' do
    let!(:branch) { FactoryGirl.create(:branch) }
    let!(:rank) { FactoryGirl.create(:rank) }
    let!(:clearance_level) { FactoryGirl.create(:clearance_level) }
    let!(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    describe 'for valid military' do
      let(:military) { FactoryGirl.create(:military, consultant: consultant) }

      it { should permit_action(:create)  }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:show)    }
      it { should permit_action(:new)     }

      it { should_not permit_action(:index)   }
      it { should_not permit_action(:destroy) }

    end
  end

  describe 'for a visitor' do
    let(:consultant) { nil }

    it 'raises an error' do
      expect { permit_action(:show) }.to_not raise_error
    end
  end
end
