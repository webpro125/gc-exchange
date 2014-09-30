require 'spec_helper'

describe 'sales_leads/new.html.erb' do
  before do
    assign(:sales_lead, FactoryGirl.build(:sales_lead))
    render
  end

  it 'should have first_name' do
    expect(rendered).to have_field('sales_lead_first_name')
  end

  it 'should have last_name' do
    expect(rendered).to have_field('sales_lead_last_name')
  end

  it 'should have company_name' do
    expect(rendered).to have_field('sales_lead_company_name')
  end

  it 'should have email' do
    expect(rendered).to have_field('sales_lead_email')
  end

  it 'should have phone_number' do
    expect(rendered).to have_field('sales_lead_phone_number')
  end

  it 'should have message' do
    expect(rendered).to have_field('sales_lead_message')
  end
end
