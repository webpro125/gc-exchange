require 'spec_helper'

describe 'project_histories/new.haml' do
  let(:project) { FactoryGirl.build_stubbed(:project_history) }

  before do
    assign(:project, project)
    assign(:form, ProjectHistoryForm.new(project))
    render
  end

  it 'should have customer_name' do
    expect(rendered).to have_field("project_history[customer_name_id]")
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
    expect(rendered).to have_field('project_history_start_date')
  end

  it 'should have end_date' do
    expect(rendered).to have_field('project_history_end_date')
  end

  it 'should have description' do
    expect(rendered).to have_field('project_history_description')
  end

  it 'should have project_type' do
    expect(rendered).to have_field('project_history[project_type_id]')
  end
end
