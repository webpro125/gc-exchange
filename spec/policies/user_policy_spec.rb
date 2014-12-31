require 'spec_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, record) }

  let(:company) { FactoryGirl.build(:company) }

  describe 'as owner' do
    describe 'for a user' do
      let(:user) { FactoryGirl.build(:user, owned_company: company) }
      let(:record) { FactoryGirl.create(:user, company: company) }

      it { should permit_action(:show)    }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:create)  }
      it { should permit_action(:new)     }
      it { should permit_action(:destroy) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end

    describe 'itself' do
      let(:user) { FactoryGirl.create(:user, owned_company: company) }
      let(:record) { user }

      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should_not permit_action(:destroy) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end
  end

  describe 'not included in user list user' do
    let(:record) { FactoryGirl.create(:user, :with_company) }

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      it { should permit_action(:show)    }
      it { should permit_action(:create)  }
      it { should permit_action(:new)     }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:destroy) }
      it { should permit_action(:upload_resume) }
      it { should permit_action(:upload_image) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      it { should_not permit_action(:show)    }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:destroy) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end

    describe 'for an owner' do
      let(:user) { FactoryGirl.create(:user, company: company) }

      it { should_not permit_action(:show)    }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:destroy) }
      it { should_not permit_action(:upload_resume) }
      it { should_not permit_action(:upload_image) }
    end
  end

  describe 'for a visitor' do
    let(:user) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
