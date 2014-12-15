require 'spec_helper'

describe UploadResumesController do
  describe 'routing' do

    describe 'routing' do

      it 'routes to upload_resumes#new' do
        get('/consultants/1/upload_resumes/new').should route_to('upload_resumes#new',
                                                                 consultant_id: '1')
      end

      it 'routes to upload_resumes#create' do
        post('/consultants/1/upload_resumes').should route_to('upload_resumes#create',
                                                              consultant_id: '1')
      end
    end
  end
end
