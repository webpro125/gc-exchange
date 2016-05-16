require 'spec_helper'

describe Api::GeoUsersController do
  let!(:user){ create(:user) }
  it 'gets the users' do
    get :index
    expect(assigns[:users]).to include user
  end
end
