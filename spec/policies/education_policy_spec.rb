require 'spec_helper'

describe EducationPolicy do
  subject { EducationPolicy.new(consultant, education) }

  describe 'for a user' do
    let!(:education) { FactoryGirl.create(:education) }
    let(:consultant) { education.consultant }

    it { should permit_action(:show)    }
    it { should permit_action(:create)  }
    it { should permit_action(:new)     }
    it { should permit_action(:update)  }
    it { should permit_action(:edit)    }
    it { should permit_action(:destroy) }
  end

  describe 'for a visitor' do
    let(:consultant) { nil }
    let(:education) { FactoryGirl.create(:education) }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
