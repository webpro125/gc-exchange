require 'spec_helper'

describe ApprovedStatus do
  it_behaves_like 'lookup'

  subject { ApprovedStatus.new(code: 'NEW_STATUS') }

  describe 'class methods' do
    subject { ApprovedStatus }

    it 'approved' do
      expect(subject.approved).to eq(subject.find_by_code(ApprovedStatus::APPROVED[:code]))
    end

    it 'in_progress' do
      expect(subject.in_progress).to eq(subject.find_by_code(ApprovedStatus::IN_PROGRESS[:code]))
    end

    it 'rejected' do
      expect(subject.rejected).to eq(subject.find_by_code(ApprovedStatus::REJECTED[:code]))
    end

    it 'pending approval' do
      expect(subject.pending_approval).to eq(subject.find_by_code(
                                               ApprovedStatus::PENDING_APPROVAL[:code]))
    end

    it 'on hold' do
      expect(subject.on_hold).to eq(subject.find_by_code(
                                               ApprovedStatus::ON_HOLD[:code]))
    end
  end
end
