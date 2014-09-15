require 'spec_helper'

describe MilitariesController do
  describe 'routing' do

    it 'should not route to military#show' do
      get('/military').should_not route_to('militaries#show')
    end

    it 'routes to military#create' do
      post('/military').should route_to('militaries#create')
    end

    it 'routes to military#new' do
      get('/military/new').should_not route_to('militaries#new')
    end

    it 'routes to military#edit' do
      get('/military/edit').should_not route_to('militaries#edit')
    end

    it 'routes to military#update' do
      put('/military').should route_to('militaries#update')
    end

    it 'should not route to military#destroy' do
      delete('/military').should route_to('militaries#destroy')
    end
  end
end
