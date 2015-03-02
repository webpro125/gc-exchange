require 'spec_helper'

describe CompaniesController do
  describe 'routing' do

    it 'routes to #index' do
      get('/contractors').should route_to('companies#index')
    end

    it 'routes to #new' do
      get('/contractors/new').should route_to('companies#new')
    end

    it 'routes to #show' do
      get('/contractors/1').should route_to('companies#show', id: '1')
    end

    it 'routes to #edit' do
      get('/contractors/1/edit').should route_to('companies#edit', id: '1')
    end

    it 'routes to #create' do
      post('/contractors').should route_to('companies#create')
    end

    it 'routes to #update' do
      put('/contractors/1').should route_to('companies#update', id: '1')
    end

    it 'routes to #destroy' do
      delete('/contractors/1').should route_to('companies#destroy', id: '1')
    end
  end
end
