require "spec_helper"

describe PagesController do
  describe "routing" do
    describe "root" do

      it 'routes to pages#home' do
        allow_any_instance_of(Object).to receive(:authenticate?).and_return(false)
        get('/').should route_to(controller: 'pages', action: 'home')
      end

      it 'routes to pages#consultant' do
        allow_any_instance_of(Object).to receive(:authenticate?).and_return(true)
        get('/').should route_to(controller: 'pages', action: 'consultant')
      end
    end
  end
end
