require 'spec_helper'

describe CompanyPolicy do
  subject { CompanyPolicy.new(user, company) }

  describe 'as owner' do
    let(:company) { FactoryGirl.create(:company, owner: user) }

    describe 'for a user' do
      let(:user) { FactoryGirl.build(:user) }

      it { should permit_action(:show)    }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:destroy) }
    end
  end

  describe 'not included in user list user' do
    let(:company) { FactoryGirl.create(:company, :with_owner) }

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user) }

      it { should permit_action(:show)    }
      it { should permit_action(:create)  }
      it { should permit_action(:new)     }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:destroy) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, :with_company) }

      it { should_not permit_action(:show)    }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:destroy) }
    end
  end

  describe 'included in user list user' do
    let(:company) { FactoryGirl.create(:company, :with_owner) }

    describe 'for GCES user' do
      let(:user) { FactoryGirl.create(:gces_user, company: company) }

      it { should permit_action(:show)    }
      it { should permit_action(:create)  }
      it { should permit_action(:new)     }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:destroy) }
    end

    describe 'for a user' do
      let(:user) { FactoryGirl.create(:user, company: company) }

      it { should permit_action(:show)    }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:destroy) }
    end
  end

  describe 'for a visitor' do
    let(:user) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
