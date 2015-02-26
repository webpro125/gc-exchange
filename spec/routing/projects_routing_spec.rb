require 'spec_helper'

describe ProjectsController do
  describe 'routing' do

    it 'routes to #index' do
      get('/offers').should route_to('projects#index')
    end

    it 'routes to #new' do
      get('/consultants/1/offers/new').should route_to('projects#new', consultant_id: '1')
    end

    it 'routes to #show' do
      get('/offers/1').should route_to('projects#show', id: '1')
    end

    it 'routes to #edit' do
      get('/offers/1/edit').should route_to('projects#edit', id: '1')
    end

    it 'routes to #create' do
      post('/consultants/1/offers').should route_to('projects#create', consultant_id: '1')
    end

    it 'routes to #update' do
      put('/offers/1').should route_to('projects#update', id: '1')
    end

    it 'routes to #destroy' do
      delete('/offers/1').should_not route_to('projects#destroy', id: '1')
    end

  end
end
