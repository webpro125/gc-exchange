require 'spec_helper'

describe PhonesController do
  describe 'routing' do

    it 'should route to phones#index' do
      get('/phones/').should route_to('phones#index')
    end

    it 'should route to phones#show' do
      get('/phones/5').should route_to('phones#show', id: '5')
    end

    it 'should routes to phones#create' do
      post('/phones').should route_to('phones#create')
    end

    it 'should routes to phones#new' do
      get('/phones/new').should route_to('phones#new')
    end

    it 'should routes to phones#edit' do
      get('/phones/5/edit').should route_to('phones#edit', id: '5')
    end

    it 'should routes to phones#update' do
      put('/phones/5').should route_to('phones#update', id: '5')
    end

    it 'should route to addresses#destroy' do
      delete('/phones/5').should route_to('phones#destroy', id: '5')
    end
  end
end
