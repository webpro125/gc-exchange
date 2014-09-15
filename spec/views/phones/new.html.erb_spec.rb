require 'spec_helper'

describe 'phones/new.html.erb' do
  let(:phone) { FactoryGirl.build_stubbed(:phone) }
  let(:phone_types) { FactoryGirl.build_stubbed_list(:phone_type, 3) }

  before do
    assign(:phone, phone)
    assign(:phone_types, phone_types)
    render
  end

  it 'should have number' do
    expect(rendered).to have_field('phone_number')
  end

  it 'should have phone_type' do
    expect(rendered).to have_field('phone_phone_type_id')
  end
end
