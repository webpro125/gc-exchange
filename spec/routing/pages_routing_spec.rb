require 'spec_helper'

describe PagesController do
  describe 'routing' do
    it 'routes to root' do
      get('/').should route_to(controller: 'pages', action: 'home')
    end
  end
end
