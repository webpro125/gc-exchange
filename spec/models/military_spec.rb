require 'spec_helper'

describe Military do
  before do
    @military = Military.new(rank: rank,
                             clearance_level: clearance_level,
                             consultant: consultant,
                             service_start_date: 1.month.ago)
  end

  let(:rank) { FactoryGirl.create(:rank) }
  let(:clearance_level) { FactoryGirl.create(:clearance_level) }
  let(:consultant) { FactoryGirl.create(:consultant) }

  subject { @military }

  it { should be_valid }

  describe 'rank' do
    it 'is not required' do
      @military.rank_id = nil
      expect(@military).to be_valid
    end
  end

  describe 'clearance_level' do
    it 'is not required' do
      @military.clearance_level_id = nil
      expect(@military).to be_valid
    end
  end

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

    it 'should be greater than today' do
      @military.service_end_date = DateTime.now
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

  describe 'associations' do
    describe 'rank' do
      it 'should be valid' do
        @military.rank_id= nil
        expect(@military).to be_valid
      end
    end

    describe 'consultant' do
      it 'should be present' do
        @military.consultant_id = nil
        expect(@military).to_not be_valid
      end

      it 'should not be destroyed on delete' do
        @military.save!
        consultant_id = @military.consultant_id

        @military.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end
  end
end
