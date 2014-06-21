require 'spec_helper'

describe DeviseController do
  describe 'routing' do

    it 'routes to sessiosn#new' do
      get('/login').should route_to('devise/sessions#new')
    end

    it 'routes to sessions#create' do
      post('/login').should route_to('devise/sessions#create')
    end

    it 'routes to #logout' do
      delete('/logout').should route_to('devise/sessions#destroy')
    end

    it 'routes to passwords#create' do
      post('/password').should route_to('devise/passwords#create')
    end

    it 'routes to passwords#new' do
      get('/password/new').should route_to('devise/passwords#new')
    end

    it 'routes to passwords#edit' do
      get('/password/edit').should route_to('devise/passwords#edit')
    end

    it 'routes to passwords#update' do
      put('/password').should route_to('devise/passwords#update')
    end

    it 'routes to registrations#cancel' do
      get('/register/cancel').should route_to('registrations#cancel')
    end

    it 'routes to registrations#create' do
      post('/register').should route_to('registrations#create')
    end

    it 'routes to registrations#new' do
      get('/register/sign_up').should route_to('registrations#new')
    end

    it 'routes to registrations#edit' do
      get('/register/edit').should route_to('registrations#edit')
    end

    it 'routes to registrations#update' do
      put('/register').should route_to('registrations#update')
    end

    it 'routes to registrations#destroy' do
      delete('/register').should route_to('registrations#destroy')
    end

    it 'routes to confirmations#create' do
      post('/confirmation').should route_to('devise/confirmations#create')
    end

    it 'routes to confirmations#new' do
      get('/confirmation/new').should route_to('devise/confirmations#new')
    end

    it 'routes to confirmations#show' do
      get('/confirmation').should route_to('devise/confirmations#show')
    end
  end
end
