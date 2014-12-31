require 'spec_helper'

describe ConsultantSetStatus do
  subject { ConsultantSetStatus.new consultant }

  describe 'status is pending approval' do
    let!(:consultant) { FactoryGirl.create(:consultant, :pending_approval) }

    describe 'approve_and_save' do
      it 'returns true' do
        expect(subject.approve_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).to receive(:save)
        subject.approve_and_save
      end

      it 'sets approved_status' do
        subject.approve_and_save
        expect(consultant.approved?).to eq true
      end
    end

    describe 'reject_and_save' do
      it 'returns true' do
        expect(subject.reject_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).to receive(:save)
        subject.reject_and_save
      end

      it 'sets approved_status' do
        subject.reject_and_save
        expect(consultant.rejected?).to eq true
      end
    end

    describe 'pending_approval_and_save' do
      it 'returns false' do
        expect(subject.pending_approval_and_save).to eq false
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.pending_approval_and_save
      end

      it 'sets approved_status' do
        subject.pending_approval_and_save
        expect(consultant.pending_approval?).to eq true
      end
    end
  end

  describe 'status is approved' do
    let!(:consultant) { FactoryGirl.create(:consultant, :approved) }

    describe 'approve_and_save' do
      it 'returns false' do
        expect(subject.approve_and_save).to eq false
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.approve_and_save
      end

      it 'sets approved_status' do
        subject.approve_and_save
        expect(consultant.approved?).to eq true
      end
    end

    describe 'reject_and_save' do
      it 'returns true' do
        expect(subject.reject_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).to receive(:save)
        subject.reject_and_save
      end

      it 'sets approved_status' do
        subject.reject_and_save
        expect(consultant.rejected?).to eq true
      end
    end

    describe 'pending_approval_and_save' do
      it 'returns false' do
        expect(subject.pending_approval_and_save).to eq false
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.pending_approval_and_save
      end

      it 'does not set approved_status' do
        subject.pending_approval_and_save
        expect(consultant.approved?).to eq true
      end
    end
  end

  describe 'status is rejected' do
    let!(:consultant) { FactoryGirl.create(:consultant, :rejected) }

    describe 'approve_and_save' do
      it 'returns true' do
        expect(subject.approve_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).to receive(:save)
        subject.approve_and_save
      end

      it 'sets approved_status' do
        subject.approve_and_save
        expect(consultant.approved?).to eq true
      end
    end

    describe 'reject_and_save' do
      it 'returns false' do
        expect(subject.reject_and_save).to eq false
      end

      it 'does not call save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.reject_and_save
      end

      it 'sets approved_status' do
        subject.reject_and_save
        expect(consultant.rejected?).to eq true
      end
    end

    describe 'pending_approval_and_save' do
      it 'returns false' do
        expect(subject.pending_approval_and_save).to eq false
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.pending_approval_and_save
      end

      it 'does not set approved_status' do
        subject.pending_approval_and_save
        expect(consultant.rejected?).to eq true
      end
    end
  end

  describe 'status is in_progress' do
    let!(:consultant) do
      FactoryGirl.create(:consultant,
                         :in_progress,
                         :wicked_finish,
                         project_histories: FactoryGirl.build_list(:project_history, 2))
    end

    describe 'approve_and_save' do
      it 'returns false' do
        expect(subject.approve_and_save).to eq false
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.approve_and_save
      end

      it 'does not set approved_status' do
        subject.approve_and_save
        expect(consultant.in_progress?).to eq true
      end
    end

    describe 'reject_and_save' do
      it 'returns false' do
        expect(subject.reject_and_save).to eq false
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).not_to receive(:save)
        subject.reject_and_save
      end

      it 'does not set approved_status' do
        subject.reject_and_save
        expect(consultant.in_progress?).to eq true
      end
    end

    describe 'pending_approval_and_save' do
      it 'returns true' do
        expect(subject.pending_approval_and_save).to eq true
      end

      it 'calls save' do
        expect_any_instance_of(Consultant).to receive(:save)
        subject.pending_approval_and_save
      end

      it 'sets approved_status' do
        subject.pending_approval_and_save
        expect(consultant.pending_approval?).to eq true
      end
    end
  end
end
