require 'spec_helper'

describe ProfilesController do
  describe 'routing' do

    it 'routes to #show' do
      get('/profile').should route_to('profiles#show')
    end

    it 'routes to #new' do
      get('/profile/new').should_not route_to('profiles#new')
    end

    it 'routes to #edit' do
      get('/profile/edit').should route_to('profiles#edit')
    end

    it 'routes to #upload' do
      get('/profile/upload').should route_to('profiles#upload')
    end

    it 'routes to #resume' do
      get('/profile/resume').should route_to('profiles#resume')
    end

    it 'routes to #create' do
      post('/profile').should_not route_to('profiles#create')
    end

    it 'routes to #update' do
      put('/profile').should route_to('profiles#update')
    end

    it 'routes to #upload_image' do
      put('/profile/upload_image').should route_to('profiles#upload_image')
      patch('/profile/upload_image').should route_to('profiles#upload_image')
    end

    it 'routes to #upload_resume' do
      put('/profile/upload_resume').should route_to('profiles#upload_resume')
      patch('/profile/upload_resume').should route_to('profiles#upload_resume')
    end

    it 'routes to #destroy' do
      delete('/profile').should_not route_to('profiles#destroy')
    end
  end
end
