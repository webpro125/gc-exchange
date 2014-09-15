require 'spec_helper'

describe 'project_histories/edit.html.erb' do
  let(:project) { FactoryGirl.build_stubbed(:project_history) }

  before do
    assign(:project, project)
    render
  end

  it 'should have customer_name' do
    expect(rendered).to have_field('project_history_customer_name_id')
  end

  it 'should have client_company' do
    expect(rendered).to have_field('project_history_client_company')
  end

  it 'should have client_poc_name' do
    expect(rendered).to have_field('project_history_client_poc_name')
  end

  it 'should have client_poc_email' do
    expect(rendered).to have_field('project_history_client_poc_email')
  end

  it 'should have start_date' do
    expect(rendered).to have_field('project_history_start_date_1i')
    expect(rendered).to have_field('project_history_start_date_2i')
    expect(rendered).to have_field('project_history_start_date_3i')
  end

  it 'should have end_date' do
    expect(rendered).to have_field('project_history_end_date_1i')
    expect(rendered).to have_field('project_history_end_date_2i')
    expect(rendered).to have_field('project_history_end_date_3i')
  end

  it 'should have position' do
    expect(rendered).to have_field('project_history_position_id')
  end

  it 'should have description' do
    expect(rendered).to have_field('project_history_description')
  end
end
