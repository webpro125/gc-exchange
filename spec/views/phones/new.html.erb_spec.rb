require 'spec_helper'

describe "phones/new.html.erb" do
  before do
    assign(:phone, FactoryGirl.build(:phone))
    assign(:phone_types, [{id: 1, code: 'CELL'}])
    render
  end

  it 'should have number' do
    expect(rendered).to have_field('phone_number')
  end

  it 'should have phone_type' do
    expect(rendered).to have_field('phone_phone_type_id')
  end
end
