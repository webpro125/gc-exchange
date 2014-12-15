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
  end
end
