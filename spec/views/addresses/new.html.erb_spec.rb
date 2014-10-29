require 'spec_helper'

describe 'addresses/new.html.erb' do
  before do
    assign(:address, FactoryGirl.build(:address))
    render
  end

  it 'should have address' do
    expect(rendered).to have_field('address_address')
  end
end
