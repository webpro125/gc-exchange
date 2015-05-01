require 'spec_helper'

describe SearchAdapter do
  subject { SearchAdapter.new(Search.new(params)) }

  describe 'with location' do
    let(:geo) { subject.to_query[:filter][:and].first[:geo_distance] }

    describe 'valid' do
      let(:params) do
        { address: 'New York City' }
      end

      it 'adds distance' do
        expect(geo).to have_key(:distance)
        expect(geo[:distance]).to eq('50mi')
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
    let(:must) { subject.to_query[:filter][:and].first[:bool][:must] }
    let(:params) do
      { project_type_ids: [1, 2, 3], position_ids: [4, 5, 6], customer_name_ids: [7, 8, 9] }
    end
    it 'adds project_type' do
      expect(must[must.keys[1]]).to have_key('project_histories.project_type.id')
      expect(must[must.keys[1]]['project_histories.project_type.id']).to eq([1, 2, 3])
    end

    it 'adds position_ids' do
      expect(must[must.keys[0]]).to(
      have_key('project_histories.project_history_positions.position.id'))

      expect(must[must.keys[0]]['project_histories.project_history_positions.position.id']).to(
      eq([4, 5, 6]))
    end

    it 'adds customer_name_ids' do
      expect(must[must.keys[2]]).to have_key('project_histories.customer_name.id')
      expect(must[must.keys[2]]['project_histories.customer_name.id']).to eq([7, 8, 9])
    end

    it 'allows empty project_type' do
      params[:project_type_ids] = []
      expect(must.size).to eq(2)
    end

    it 'allows empty position_id' do
      params[:position_ids] = []
      expect(must.size).to eq(2)
    end

    it 'allows empty customer_name' do
      params[:customer_name_ids] = []
      expect(must.size).to eq(2)
    end
  end

  describe 'should_query_params' do
    let(:should_query) { subject.to_query[:filter][:and].first[:bool][:should] }
    let(:params) do
      { certification_ids: [1, 2, 3],
        clearance_level_id: ClearanceLevel.ts_sci.id.to_s,
        q: ['testing'] }
    end

    it 'adds certification' do
      expect(should_query[should_query.keys[0]]).to include('certification.id')
      expect(should_query[should_query.keys[0]]['certification.id']).to eq([1, 2, 3])
    end

    it 'adds clearance_level_ids' do
      expect(should_query[should_query.keys[1]]).to include('military.clearance_level_id')
      expect(should_query[should_query.keys[1]]['military.clearance_level_id']).to(
        eq([ClearanceLevel.ts_sci.id.to_s]))

      expect(should_query[should_query.keys[2]]).to include('military.clearance_active')
      expect(should_query[should_query.keys[2]]['military.clearance_active'].first).to eq true
    end

    it 'allows empty clearance_level_id' do
      params[:clearance_level_id] = nil
      expect(should_query.size).to eq(1)
    end

    it 'allows empty certification' do
      params[:certification_ids] = []
      expect(should_query.size).to eq(2)
    end
  end

  describe 'keyword_query_params' do
    let(:keyword_query) { subject.to_query[:query] }
    let(:params) do
      { q: ['testing'] }
    end

    it 'adds q' do
      expect(keyword_query[:fuzzy_like_this][:like_text]).to eq(['testing'])
    end

    it 'allows empty q' do
      params[:q] = []
      expect(keyword_query[:fuzzy_like_this][:like_text]).to be_nil
    end
  end

  describe 'and queries' do
    it 'are not overwritten' do

    end
  end
end
