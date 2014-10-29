require 'spec_helper'

describe ConsultantsController do
  describe 'routing' do

    it 'routes to #index' do
      get('/consultants').should route_to('consultants#index')
    end

    it 'routes to #approve' do
      put('/consultants/1/approve').should route_to('consultants#approve', id: '1')
    end

    it 'routes to #reject' do
      put('/consultants/1/reject').should route_to('consultants#reject', id: '1')
    end

    it 'does not route to #new' do
      get('/consultants/new').should_not route_to('consultants#new')
    end

    it 'does not route to #show' do
      get('/consultants/1').should_not route_to('consultants#show', id: '1')
    end

    it 'does not route to #edit' do
      get('/consultants/1/edit').should_not route_to('consultants#edit', id: '1')
    end

    it 'does not route to #create' do
      post('/consultants').should_not route_to('consultants#create')
    end

    it 'does not route to #update' do
      put('/consultants/1').should_not route_to('consultants#update', id: '1')
    end

    it 'does not route to #destroy' do
      delete('/consultants/1').should_not route_to('consultants#destroy', id: '1')
    end
  end
end
