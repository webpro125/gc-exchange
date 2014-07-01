require 'spec_helper'

describe AddressesController do
  describe 'routing' do

    it 'routes to addresses#show' do
      get('/address').should route_to('addresses#show')
    end

    it 'routes to addresses#create' do
      post('/address').should route_to('addresses#create')
    end

    it 'routes to addresses#new' do
      get('/address/new').should route_to('addresses#new')
    end

    it 'routes to addresses#edit' do
      get('/address/edit').should route_to('addresses#edit')
    end

    it 'routes to addresses#update' do
      put('/address').should route_to('addresses#update')
    end

    it 'should not route to addresses#show' do
      delete('/address').should_not route_to('addresses#destroy')
    end
  end
end
