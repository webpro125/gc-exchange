require 'spec_helper'

describe ProjectHistoriesController do
  describe 'routing' do

    it 'routes to #index' do
      get('/projects').should route_to('project_histories#index')
    end

    it 'routes to #new' do
      get('/projects/new').should route_to('project_histories#new')
    end

    it 'routes to #show' do
      get('/projects/1').should route_to('project_histories#show', id: '1')
    end

    it 'routes to #edit' do
      get('/projects/1/edit').should route_to('project_histories#edit', id: '1')
    end

    it 'routes to #create' do
      post('/projects').should route_to('project_histories#create')
    end

    it 'routes to #update' do
      put('/projects/1').should route_to('project_histories#update', id: '1')
    end

    it 'routes to #destroy' do
      delete('/projects/1').should route_to('project_histories#destroy', id: '1')
    end
  end
end
