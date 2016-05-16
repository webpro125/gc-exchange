require 'spec_helper'

describe "Geo Users Json" do
  let!(:user){ create(:user) }
  let(:address){ create(:address, latitude: 25, longitude: 35) }
  let!(:consultant){ create(:consultant, :approved, user: user, address: address) }

  it 'is successful' do
    get "/api/geo_users.json"
    expect(response).to be_success
  end

  it 'displays the correct structure' do
    get "/api/geo_users.json"
    expect(json['features'].first['properties']['firstName']).to eq user.first_name
    expect(json['features'].first['properties']['lastName']).to eq user.last_name
    expect(json['features'].first['geometry']['coordinates']).to eq address.coordinates
  end
end

def json
  JSON.parse(response.body)
end
