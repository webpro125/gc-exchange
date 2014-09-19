require 'spec_helper'

describe 'project_histories/show.html.erb' do
  let(:customer_name) { 'MAH NAME' }
  let(:customer) { FactoryGirl.build_stubbed(:customer_name) }
  let(:policy) { allow(view).to receive(:policy) }
  let(:project) do
    FactoryGirl.build_stubbed(:project_history,
                              customer_name: customer)
  end

  before do
    assign(:project, project)
    view.stub(:lookup_translation).with(CustomerName, customer.code).and_return(customer_name)
  end

  describe 'with access' do
    before do
      policy.and_return double(edit?: true, destroy?: true)
      render
    end

    it 'should have customer_name' do
      expect(rendered).to have_text(customer_name)
    end

    it 'should have client_company' do
      expect(rendered).to have_text(project.client_company)
    end

    it 'should have client_poc_name' do
      expect(rendered).to have_text(project.client_poc_name)
    end

    it 'should have client_poc_email' do
      expect(rendered).to have_text(project.client_poc_email)
    end

    it 'should have start_date' do
      expect(rendered).to have_text(project.start_date.to_formatted_s(:long))
    end

    it 'should have end_date' do
      expect(rendered).to have_text(project.end_date.to_formatted_s(:long))
    end

    it 'should have description' do
      expect(rendered).to have_text(project.description)
    end

    it 'should have a link to edit' do
      expect(rendered).to have_link(I18n.t('views.project.actions.edit'))
    end

    it 'should have a link to delete' do
      expect(rendered).to have_link(I18n.t('views.project.actions.delete'))
    end
  end

  describe 'without access to' do
    describe 'edit' do
      before do
        policy.and_return double(edit?: false, destroy?: true)
        render
      end

      it 'should have customer_name' do
        expect(rendered).to have_text(customer_name)
      end

      it 'should have client_company' do
        expect(rendered).to have_text(project.client_company)
      end

      it 'should have client_poc_name' do
        expect(rendered).to have_text(project.client_poc_name)
      end

      it 'should have client_poc_email' do
        expect(rendered).to have_text(project.client_poc_email)
      end

      it 'should have start_date' do
        expect(rendered).to have_text(project.start_date.to_formatted_s(:long))
      end

      it 'should have end_date' do
        expect(rendered).to have_text(project.end_date.to_formatted_s(:long))
      end

      it 'should have description' do
        expect(rendered).to have_text(project.description)
      end

      it 'should not have a link to edit' do
        expect(rendered).not_to have_link(I18n.t('views.project.actions.edit'))
      end

      it 'should have a link to delete' do
        expect(rendered).to have_link(I18n.t('views.project.actions.delete'))
      end
    end

    describe 'destroy' do
      before do
        policy.and_return double(edit?: true, destroy?: false)
        render
      end

      it 'should have customer_name' do
        expect(rendered).to have_text(customer_name)
      end

      it 'should have client_company' do
        expect(rendered).to have_text(project.client_company)
      end

      it 'should have client_poc_name' do
        expect(rendered).to have_text(project.client_poc_name)
      end

      it 'should have client_poc_email' do
        expect(rendered).to have_text(project.client_poc_email)
      end

      it 'should have start_date' do
        expect(rendered).to have_text(project.start_date.to_formatted_s(:long))
      end

      it 'should have end_date' do
        expect(rendered).to have_text(project.end_date.to_formatted_s(:long))
      end

      it 'should have description' do
        expect(rendered).to have_text(project.description)
      end

      it 'should have a link to edit' do
        expect(rendered).to have_link(I18n.t('views.project.actions.edit'))
      end

      it 'should not have a link to delete' do
        expect(rendered).not_to have_link(I18n.t('views.project.actions.delete'))
      end
    end
  end
end
