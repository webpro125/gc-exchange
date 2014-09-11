require 'spec_helper'

describe ProjectHistoryPolicy do
  subject { ProjectHistoryPolicy.new(consultant, project_history) }

  describe 'for a user' do
    let(:consultant) { FactoryGirl.create(:confirmed_consultant) }

    describe 'for valid project_history' do
      let(:project_history) { FactoryGirl.create(:project_history, consultant: consultant) }

      it { should permit(:show)    }
      it { should permit(:create)  }
      it { should permit(:new)     }
      it { should permit(:update)  }
      it { should permit(:edit)    }
      it { should permit(:destroy) }
    end

    describe 'for another project_history' do
      let(:project_history) { FactoryGirl.create(:project_history) }

      it { should_not permit(:show)    }
      it { should_not permit(:create)  }
      it { should_not permit(:new)     }
      it { should_not permit(:update)  }
      it { should_not permit(:edit)    }
      it { should_not permit(:destroy) }
    end
  end

  describe 'for a visitor' do
    let(:consultant) { nil }

    it 'raises an error' do
      expect { permit(:show) }.to_not raise_error
    end
  end
end
