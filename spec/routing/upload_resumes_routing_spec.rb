require 'spec_helper'

describe UploadResumesController do
  describe 'routing' do

    it 'routes to upload_resumes#new' do
      get('/consultants/1/upload_resumes/new').should route_to('upload_resumes#new',
                                                               consultant_id: '1')
    end

    it 'routes to upload_resumes#create' do
      post('/consultants/1/upload_resumes').should route_to('upload_resumes#create',
                                                            consultant_id: '1')
    end

    it 'does not route to #show' do
      get('/consultants/1').should_not route_to('upload_resumes#show', consultant_id: '1')
    end

    it 'does not route to #edit' do
      get('/consultants/1/edit').should_not route_to('upload_resumes#edit', consultant_id: '1')
    end

    it 'does not route to #update' do
      put('/consultants/1').should_not route_to('upload_resumes#update', consultant_id: '1')
    end

    it 'does not route to #destroy' do
      delete('/consultants/1').should_not route_to('upload_resumes#destroy', consultant_id: '1')
    end

    it 'does not route to #index' do
      get('/consultants').should_not route_to('upload_resumes#index')
    end
  end
end
