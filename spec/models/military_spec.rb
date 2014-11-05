require 'spec_helper'

describe Military do
  it_behaves_like 'indexable', :service_start_date=, 2.months.ago

  let!(:branch) { FactoryGirl.create(:branch) }
  let!(:rank) { FactoryGirl.create(:rank) }
  let!(:clearance_level) { FactoryGirl.create(:clearance_level) }
  let!(:consultant) { FactoryGirl.create(:consultant, :approved) }

  subject do
    Military.new(branch: branch,
                 rank: rank,
                 clearance_level: clearance_level,
                 consultant: consultant,
                 service_start_date: 1.month.ago)
  end

  it { should be_valid }

  describe 'associations' do
    describe 'rank' do
      it 'should not be destroyed on delete' do
        subject.save!
        rank_id = subject.rank_id

        subject.destroy
        expect(Rank.find_by_id(rank_id)).not_to be_nil
      end
    end

    describe 'clearance_level' do
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
      it 'should not be destroyed on delete' do
        subject.save!
        branch_id = subject.branch_id

        subject.destroy
        expect(Branch.find_by_id(branch_id)).not_to be_nil
      end
    end
  end
end
