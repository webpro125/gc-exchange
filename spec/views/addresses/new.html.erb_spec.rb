require 'spec_helper'

describe 'addresses/new.html.erb' do
  before do
    assign(:address, FactoryGirl.build(:address))
    render
  end

  it 'should have address1' do
    expect(rendered).to have_field('address_address1')
  end

  it 'should have address2' do
    expect(rendered).to have_field('address_address2')
  end

  it 'should have city' do
    expect(rendered).to have_field('address_city')
  end

  it 'should have state' do
    expect(rendered).to have_field('address_state')
  end

  it 'should have zipcode' do
    expect(rendered).to have_field('address_zipcode')
  end
end
