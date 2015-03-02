require 'spec_helper'

describe UsersController do
  describe 'routing' do

    it 'routes to #index' do
      get('/contractors/1/users').should route_to('users#index', company_id: '1')
    end

    it 'routes to #new' do
      get('/contractors/1/users/new').should route_to('users#new', company_id: '1')
    end

    it 'routes to #show' do
      get('/contractors/1/users/1').should route_to('users#show', company_id: '1', id: '1')
    end

    it 'routes to #edit' do
      get('/contractors/1/users/1/edit').should route_to('users#edit', company_id: '1', id: '1')
    end

    it 'routes to #create' do
      post('/contractors/1/users').should route_to('users#create', company_id: '1')
    end

    it 'routes to #update' do
      put('/contractors/1/users/1').should route_to('users#update', company_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      delete('/contractors/1/users/1').should route_to('users#destroy', company_id: '1', id: '1')
    end
  end
end
