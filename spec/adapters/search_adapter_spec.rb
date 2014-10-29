require 'spec_helper'

describe SearchAdapter do
  subject { SearchAdapter.new(Search.new(params)) }

  describe 'with location' do
    let(:geo) { subject.to_query[:filter][:and].first[:geo_distance] }

    describe 'valid' do
      let(:params) do
        { distance: 30, address: 'New York City' }
      end

      it 'adds distance' do
        expect(geo).to have_key(:distance)
        expect(geo[:distance]).to eq('30mi')
      end

      it 'adds lat' do
        expect(geo[:address]).to have_key(:lat)
        expect(geo[:address][:lat]).not_to be_nil
      end

      it 'adds lon' do
        expect(geo[:address]).to have_key(:lon)
        expect(geo[:address][:lon]).not_to be_nil
      end
    end

    describe 'invalid' do
      let(:params) do
        { distance: 30 }
      end

      it 'throws exception' do
        expect { geo }.to raise_error
      end
    end
  end

  describe 'must_params' do
    let(:must) { subject.to_query[:filter][:and].first[:bool][:must][:terms] }
    let(:params) do
      { project_type_ids: [1, 2, 3], position_ids: [4, 5, 6], customer_name_ids: [7, 8, 9] }
    end
    it 'adds project_type' do
      expect(must).to have_key('project_histories.project_type.id')
      expect(must['project_histories.project_type.id']).to eq([1, 2, 3])
    end

    it 'adds position_ids' do
      expect(must).to have_key('project_histories.project_history_positions.position.id')
      expect(must['project_histories.project_history_positions.position.id']).to eq([4, 5, 6])
    end

    it 'adds customer_name_ids' do
      expect(must).to have_key('project_histories.customer_name.id')
      expect(must['project_histories.customer_name.id']).to eq([7, 8, 9])
    end

    it 'allows empty customer_name' do
      params[:customer_name_ids] = []
      expect(must).to_not have_key('project_histories.customer_name.id')
    end
  end

  describe 'should_params' do
    let(:should) { subject.to_query[:filter][:and].first[:bool][:should][:terms] }
    let(:params) do
      { certification_ids: [1, 2, 3], clearance_level_ids: [4, 5, 6] }
    end

    it 'adds certification' do
      expect(should).to have_key('certification.id')
      expect(should['certification.id']).to eq([1, 2, 3])
    end

    it 'adds clearance_level_ids' do
      expect(should).to have_key('military.clearance_level_id')
      expect(should['military.clearance_level_id']).to eq([4, 5, 6])
    end

    it 'adds clearance_active' do
      expect(should).to have_key('military.clearance_active')
      expect(should['military.clearance_active']).to eq true
    end
  end
end
