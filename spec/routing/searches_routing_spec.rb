require 'spec_helper'

describe SearchesController do
  describe 'routing' do

    it 'should route to searches#show' do
      get('/search').should_not route_to('searches#show')
    end

    it 'should not routes to searches#create' do
      post('/search').should_not route_to('searches#create')
    end

    it 'should route to searches#new' do
      get('/search').should route_to('searches#new')
    end

    it 'should not route to searches#edit' do
      get('/search/edit').should_not route_to('searches#edit')
    end

    it 'should not route to searches#update' do
      put('/search').should_not route_to('searches#update')
    end

    it 'should not route to searches#destroy' do
      delete('/search').should_not route_to('searches#destroy')
    end

    it 'should route to searches#skills' do
      get('/search/skills').should route_to('searches#skills')
    end
  end
end
