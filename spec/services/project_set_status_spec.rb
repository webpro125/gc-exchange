require 'spec_helper'

describe ProjectSetStatus do
  subject { ProjectSetStatus.new project }

  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:user) { FactoryGirl.create(:user, :with_company) }

  describe 'status is offered' do
    let(:project) { FactoryGirl.create(:project, contact_status: :offered) }

    describe '#agree_to_terms_and_save' do
      it 'returns true' do
        expect(subject.agree_to_terms_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Project).to receive(:save)
        subject.agree_to_terms_and_save
      end

      it 'sets offered_agreed_to_terms_status' do
        subject.agree_to_terms_and_save
        expect(project.agreed_to_terms?).to eq true
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.offer_and_save
      end

      it 'sets under_revision_status' do
        subject.offer_and_save
        expect(project.offered?).to eq true
      end
    end

    describe '#not_interested_and_save' do
      it 'returns true' do
        expect(subject.not_interested_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Project).to receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(project.not_interested?).to eq true
      end
    end

    describe '#not_pursuing_and_save' do
      it 'returns true' do
        expect(subject.not_pursuing_and_save).to eq true
      end

      it 'does call save' do
        expect_any_instance_of(Project).to receive(:save)
        subject.not_pursuing_and_save
      end

      it 'sets not_pursuing' do
        subject.not_pursuing_and_save
        expect(project.not_pursuing?).to eq true
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.offer_and_save
      end

      it 'sets offered' do
        subject.offer_and_save
        expect(project.offered?).to eq true
      end
    end
  end

  describe 'status is not_interested' do
    let(:project) { FactoryGirl.create(:project, contact_status: :not_interested) }

    describe '#agree_to_terms_and_save' do
      it 'returns false' do
        expect(subject.agree_to_terms_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.agree_to_terms_and_save
      end

      it 'sets agreed_to_terms_status' do
        subject.agree_to_terms_and_save
        expect(project.agreed_to_terms?).to eq false
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.offer_and_save
      end

      it 'sets under_revision_status' do
        subject.offer_and_save
        expect(project.under_revision?).to eq false
      end
    end

    describe '#not_interested_and_save' do
      it 'returns false' do
        expect(subject.not_interested_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(project.not_interested?).to eq true
      end
    end

    describe '#not_pursuing_and_save' do
      it 'returns false' do
        expect(subject.not_pursuing_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.not_pursuing_and_save
      end

      it 'sets not_pursuing' do
        subject.not_pursuing_and_save
        expect(project.not_pursuing?).to eq false
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.offer_and_save
      end

      it 'sets offered' do
        subject.offer_and_save
        expect(project.offered?).to eq false
      end
    end
  end

  describe 'status is not_pursuing' do
    let(:project) { FactoryGirl.create(:project, contact_status: :not_pursuing) }

    describe '#agree_to_terms_and_save' do
      it 'returns false' do
        expect(subject.agree_to_terms_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.agree_to_terms_and_save
      end

      it 'sets offered_agreed_to_terms_status' do
        subject.agree_to_terms_and_save
        expect(project.agreed_to_terms?).to eq false
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.offer_and_save
      end

      it 'sets under_revision_status' do
        subject.offer_and_save
        expect(project.under_revision?).to eq false
      end
    end

    describe '#not_interested_and_save' do
      it 'returns false' do
        expect(subject.not_interested_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(project.not_interested?).to eq false
      end
    end

    describe '#not_pursuing_and_save' do
      it 'returns false' do
        expect(subject.not_pursuing_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.not_pursuing_and_save
      end

      it 'sets not_pursuing' do
        subject.not_pursuing_and_save
        expect(project.not_pursuing?).to eq true
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.offer_and_save
      end

      it 'sets offered' do
        subject.offer_and_save
        expect(project.offered?).to eq false
      end
    end
  end

  describe 'status is agree_to_terms' do
    let(:project) { FactoryGirl.create(:project, contact_status: :agreed_to_terms) }

    describe '#agree_to_terms_and_save' do
      it 'returns false' do
        expect(subject.agree_to_terms_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.agree_to_terms_and_save
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.offer_and_save
      end
    end

    describe '#not_interested_and_save' do
      it 'returns false' do
        expect(subject.not_interested_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.not_interested_and_save
      end
    end

    describe '#not_pursuing_and_save' do
      it 'returns false' do
        expect(subject.not_pursuing_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.not_pursuing_and_save
      end
    end

    describe '#offer_and_save' do
      it 'returns false' do
        expect(subject.offer_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.offer_and_save
      end

      it 'sets offered' do
        subject.offer_and_save
        expect(project.offered?).to eq false
      end
    end
  end

  describe 'status is under_revision' do
    let(:project) { FactoryGirl.create(:project, contact_status: :under_revision) }

    describe '#agree_to_terms_and_save' do
      it 'returns false' do
        expect(subject.agree_to_terms_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).not_to receive(:save)
        subject.agree_to_terms_and_save
      end

      it 'sets agreed_to_terms_status' do
        subject.agree_to_terms_and_save
        expect(project.agreed_to_terms?).to eq false
      end
    end

    describe '#offer_and_save' do
      it 'returns true' do
        expect(subject.offer_and_save).to eq true
      end

      it 'does call save' do
        expect_any_instance_of(Project).to receive(:save)
        subject.offer_and_save
      end

      it 'sets under_revision_status' do
        subject.offer_and_save
        expect(project.offered?).to eq true
      end
    end

    describe '#not_interested_and_save' do
      it 'returns false' do
        expect(subject.not_interested_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to_not receive(:save)
        subject.not_interested_and_save
      end

      it 'sets not_interested_status' do
        subject.not_interested_and_save
        expect(project.not_interested?).to eq false
      end
    end

    describe '#not_pursuing_and_save' do
      it 'returns true' do
        expect(subject.not_pursuing_and_save).to eq true
      end

      it 'does not call save' do
        expect_any_instance_of(Project).to receive(:save)
        subject.not_pursuing_and_save
      end

      it 'sets not_pursuing' do
        subject.not_pursuing_and_save
        expect(project.not_pursuing?).to eq true
      end
    end

    describe '#offer_and_save' do
      it 'returns true' do
        expect(subject.offer_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Project).to receive(:save)
        subject.offer_and_save
      end

      it 'sets offered' do
        subject.offer_and_save
        expect(project.offered?).to eq true
      end
    end
  end
end
