require 'spec_helper'

describe SalesLeadsController do
  describe 'routing' do

    it 'should not route to sales_leads#show' do
      get('/sales_leads').should_not route_to('sales_leads#show')
    end

    it 'routes to sales_leads#create' do
      post('/sales_leads').should route_to('sales_leads#create')
    end

    it 'routes to sales_leads#new' do
      get('/sales_leads/new').should route_to('sales_leads#new')
    end

    it 'should not route to sales_leads#edit' do
      get('/sales_leads/edit').should_not route_to('sales_leads#edit')
    end

    it 'should not route to sales_leads#update' do
      put('/sales_leads').should_not route_to('sales_leads#update')
    end

    it 'should not route to sales_leads#destroy' do
      delete('/sales_leads').should_not route_to('sales_leads#destroy')
    end
  end
end
