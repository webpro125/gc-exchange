require 'spec_helper'

describe ProjectHistoryPolicy do
  subject { ProjectHistoryPolicy.new(consultant, project_history) }

  describe 'for a user' do
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    describe 'for valid project_history' do
      let(:project_history) { FactoryGirl.create(:project_history, consultant: consultant) }

      it { should permit_action(:show)    }
      it { should permit_action(:create)  }
      it { should permit_action(:new)     }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:destroy) }
    end

    describe 'for another project_history' do
      let(:project_history) { FactoryGirl.create(:project_history) }

      it { should_not permit_action(:show)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:destroy) }
    end
  end

  describe 'for a visitor' do
    let(:consultant) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
