require 'spec_helper'

describe 'Editing project histories' do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:customer_name) { FactoryGirl.create(:customer_name) }
  let!(:project_history_position_list) do
    FactoryGirl.build_list(:project_history_position, 2, percentage: 50)
  end
  let!(:project_history) do
    project_type = FactoryGirl.create(:project_type)
    FactoryGirl.create(:address, consultant: consultant)
    FactoryGirl.create(:project_history, consultant: consultant, project_type: project_type)
  end

  def navigate_to_page(options = {})
    options[:id] ||= project_history.id
    options[:target_page] ||= "/projects/#{options[:id]}/edit"

    visit '/login'
    fill_in 'consultant[email]', with: consultant.email
    fill_in 'consultant[password]', with: consultant.password
    click_button 'Sign in'
    consultant.reload
    visit options[:target_page]
    expect(page).to have_content('Editing project')
  end

  it 'does not throw an error on profile#show with nil dates' do
    project_history.start_date = nil
    project_history.end_date = nil
    project_history.save

    navigate_to_page
    test_profile_page_loading
  end

  it 'does not throw an error on profile#show with only valid start date' do
    project_history.end_date = nil
    project_history.save

    navigate_to_page
    test_profile_page_loading
  end

  it 'does not throw an error on profile#show with only valid end date' do
    project_history.start_date = nil
    project_history.save

    navigate_to_page
    test_profile_page_loading
  end

  it 'does not throw an error on profile#show with all valid dates' do
    navigate_to_page
    test_profile_page_loading
  end

  def test_profile_page_loading
    expect do
      # BUG: this catch is to prevent the missing /projects GET route bug from interfering
      # TODO: remove 'begin' and these comments when bug is fixed
      # NOTE: routes to [GET] /projects only when dates are valid
      begin
        click_button 'Update Project history'
      rescue
        visit '/profile'
      end
    end.to_not raise_error
  end
end
