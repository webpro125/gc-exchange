require 'spec_helper'

describe UploadImagesController do
  describe 'routing' do

    it 'routes to upload_images#new' do
      get('/consultants/1/upload_images/new').should route_to('upload_images#new',
                                                              consultant_id: '1')
    end

    it 'routes to upload_images#create' do
      post('/consultants/1/upload_images').should route_to('upload_images#create',
                                                           consultant_id: '1')
    end

    it 'does not route to #show' do
      get('/consultants/1').should_not route_to('upload_images#show', consultant_id: '1')
    end

    it 'does not route to #edit' do
      get('/consultants/1/edit').should_not route_to('upload_images#edit', consultant_id: '1')
    end

    it 'does not route to #update' do
      put('/consultants/1').should_not route_to('upload_images#update', consultant_id: '1')
    end

    it 'does not route to #destroy' do
      delete('/consultants/1').should_not route_to('upload_images#destroy', consultant_id: '1')
    end

    it 'does not route to #index' do
      get('/consultants').should_not route_to('upload_images#index')
    end
  end
end
