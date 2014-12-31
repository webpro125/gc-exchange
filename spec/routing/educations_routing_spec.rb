require 'spec_helper'

describe EducationsController do
  describe 'routing' do

    it 'should route to educations#index' do
      get('/educations/').should_not route_to('educations#index')
    end

    it 'should route to educations#show' do
      get('/educations/5').should_not route_to('educations#show', id: '5')
    end

    it 'should routes to educations#create' do
      post('/educations').should route_to('educations#create')
    end

    it 'should routes to educations#new' do
      get('/educations/new').should route_to('educations#new')
    end

    it 'should routes to educations#edit' do
      get('/educations/5/edit').should_not route_to('educations#edit', id: '5')
    end

    it 'should routes to educations#update' do
      put('/educations/5').should_not route_to('educations#update', id: '5')
    end

    it 'should route to addresses#destroy' do
      delete('/educations/5').should route_to('educations#destroy', id: '5')
    end
  end
end
