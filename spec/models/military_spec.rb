require 'spec_helper'

describe Military do
  before do
    @military = Military.new(branch: branch,
                             rank: rank,
                             clearance_level: clearance_level,
                             consultant: consultant,
                             service_start_date: 1.month.ago)
  end

  let(:branch) { FactoryGirl.create(:branch) }
  let(:rank) { FactoryGirl.create(:rank) }
  let(:clearance_level) { FactoryGirl.create(:clearance_level) }
  let(:consultant) { FactoryGirl.create(:consultant) }

  subject { @military }

  it { should be_valid }

  describe 'service_start_date' do
    it 'is not required' do
      @military.service_start_date = nil
      expect(@military).to be_valid
    end
  end

  describe 'service_end_date' do
    it 'is not required' do
      @military.service_end_date = nil
      expect(@military).to be_valid
    end

    it 'should not be greater than today' do
      @military.service_end_date = 1.day.from_now
      expect(@military).not_to be_valid
    end

    it 'should not be less than start_date' do
      @military.service_end_date = 3.years.ago
      expect(@military).not_to be_valid
    end
  end

  describe 'investigation_date' do
    it 'is not required' do
      @military.investigation_date = nil
      expect(@military).to be_valid
    end
  end

  describe 'clearance_expiration_date' do
    it 'is not required' do
      @military.clearance_expiration_date = nil
      expect(@military).to be_valid
    end
  end

  describe 'clearance_status' do
    it 'is required' do
      expect(@military.clearance_status).to be false
    end
  end

  describe 'associations' do
    describe 'rank' do
      it 'is not required' do
        @military.rank = nil
        expect(@military).to be_valid
      end

      it 'should not be destroyed on delete' do
        @military.save!
        rank_id = @military.rank_id

        @military.destroy
        expect(Rank.find_by_id(rank_id)).not_to be_nil
      end
    end

    describe 'clearance_level' do
      it 'is not required' do
        @military.clearance_level = nil
        expect(@military).to be_valid
      end

      it 'should not be destroyed on delete' do
        @military.save!
        clearance_level_id = @military.clearance_level_id

        @military.destroy
        expect(ClearanceLevel.find_by_id(clearance_level_id)).not_to be_nil
      end
    end

    describe 'consultant' do
      it 'should be present' do
        @military.consultant = nil
        expect(@military).to_not be_valid
      end

      it 'should not be destroyed on delete' do
        @military.save!
        consultant_id = @military.consultant_id

        @military.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'service_branch' do
      it 'is defaulted to false' do
        expect(@military).to be_valid
      end

      it 'should not be destroyed on delete' do
        @military.save!
        branch_id = @military.branch_id

        @military.destroy
        expect(Branch.find_by_id(branch_id)).not_to be_nil
      end
    end
  end
end
