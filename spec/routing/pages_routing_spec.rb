require 'spec_helper'

describe PagesController do
  describe 'routing' do
    describe 'root' do

      it 'routes to pages#home' do
        allow_message_expectations_on_nil
        allow_any_instance_of(Object).to receive(:authenticate?).and_return(false)
        get('/').should route_to(controller: 'pages', action: 'home')
      end
    end
  end
end
