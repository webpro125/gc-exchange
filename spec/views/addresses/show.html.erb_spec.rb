require 'spec_helper'

describe "addresses/show.html.erb" do
  before do
    @address = FactoryGirl.build(:address, address2: 'test')
    assign(:address, @address)
    render
  end

  it 'should have address1' do
    expect(rendered).to have_content(@address.address1)
  end

  it 'should have address2' do
    expect(rendered).to have_content(@address.address2)
  end

  it 'should have city' do
    expect(rendered).to have_content(@address.city)
  end

  it 'should have state' do
    expect(rendered).to have_content(@address.state)
  end

  it 'should have zipcode' do
    expect(rendered).to have_content(@address.zipcode)
  end
end
