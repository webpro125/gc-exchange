require 'spec_helper'

describe Military do
  it_behaves_like 'indexable', :service_start_date=, 2.months.ago

  let!(:branch) { FactoryGirl.create(:branch) }
  let!(:rank) { FactoryGirl.create(:rank) }
  let!(:clearance_level) { FactoryGirl.create(:clearance_level) }
  let!(:consultant) { FactoryGirl.create(:consultant, approved: true) }

  subject do
    Military.new(branch: branch,
                 rank: rank,
                 clearance_level: clearance_level,
                 consultant: consultant,
                 service_start_date: 1.month.ago)
  end

  it { should be_valid }

  describe 'service_start_date' do
    it 'is not required' do
      subject.service_start_date = nil
      expect(subject).to be_valid
    end
  end

  describe 'service_end_date' do
    it 'is not required' do
      subject.service_end_date = nil
      expect(subject).to be_valid
    end

    it 'should not be greater than today' do
      subject.service_end_date = 1.day.from_now
      expect(subject).not_to be_valid
    end

    it 'should not be less than start_date' do
      subject.service_end_date = 3.years.ago
      expect(subject).not_to be_valid
    end
  end

  describe 'investigation_date' do
    it 'is not required' do
      subject.investigation_date = nil
      expect(subject).to be_valid
    end
  end

  describe 'clearance_expiration_date' do
    it 'is not required' do
      subject.clearance_expiration_date = nil
      expect(subject).to be_valid
    end
  end

  describe 'clearance_status' do
    it 'is required' do
      expect(subject.clearance_status).to be false
    end
  end

  describe 'associations' do
    describe 'rank' do
      it 'is not required' do
        subject.rank = nil
        expect(subject).to be_valid
      end

      it 'should not be destroyed on delete' do
        subject.save!
        rank_id = subject.rank_id

        subject.destroy
        expect(Rank.find_by_id(rank_id)).not_to be_nil
      end
    end

    describe 'clearance_level' do
      it 'is not required' do
        subject.clearance_level = nil
        expect(subject).to be_valid
      end

      it 'should not be destroyed on delete' do
        subject.save!
        clearance_level_id = subject.clearance_level_id

        subject.destroy
        expect(ClearanceLevel.find_by_id(clearance_level_id)).not_to be_nil
      end
    end

    describe 'consultant' do
      it 'should be present' do
        subject.consultant = nil
        expect(subject).to_not be_valid
      end

      it 'should not be destroyed on delete' do
        subject.save!
        consultant_id = subject.consultant_id

        subject.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'service_branch' do
      it 'is defaulted to false' do
        expect(subject).to be_valid
      end

      it 'should not be destroyed on delete' do
        subject.save!
        branch_id = subject.branch_id

        subject.destroy
        expect(Branch.find_by_id(branch_id)).not_to be_nil
      end
    end
  end
end
