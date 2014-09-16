require 'spec_helper'

describe 'project_histories/index.html.erb' do
  let(:projects) { FactoryGirl.build_stubbed_list(:project_history, 3) }
  let(:policy) { allow(view).to receive(:policy) }

  before do
    assign(:projects, projects)
    view.stub(:lookup_translation).and_return('hi')
  end

  describe 'access to everything' do
    before do
      policy.and_return double(edit?: true, destroy?: true)
      render
    end

    it 'should have company' do
      projects.each do |project|
        expect(rendered).to have_text(project.client_company)
      end
    end

    it 'should have a link to show' do
      projects.each do |project|
        expect(rendered).to have_link(project.client_company)
      end
    end

    it 'should have a link to edit' do
      expect(rendered).to have_link(I18n.t('views.project.actions.edit'))
    end

    it 'should have a link to add' do
      expect(rendered).to have_link(I18n.t('views.project.actions.add'))
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

      it 'should have company' do
        projects.each do |project|
          expect(rendered).to have_text(project.client_company)
        end
      end

      it 'should have a link to show' do
        projects.each do |project|
          expect(rendered).to have_link(project.client_company)
        end
      end

      it 'should not have a link to edit' do
        expect(rendered).not_to have_link(I18n.t('views.project.actions.edit'))
      end

      it 'should have a link to add' do
        expect(rendered).to have_link(I18n.t('views.project.actions.add'))
      end

      it 'should have a link to delete' do
        expect(rendered).to have_link(I18n.t('views.project.actions.delete'))
      end
    end

    describe 'delete' do
      before do
        policy.and_return double(edit?: true, destroy?: false)
        render
      end

      it 'should have company' do
        projects.each do |project|
          expect(rendered).to have_text(project.client_company)
        end
      end

      it 'should have a link to show' do
        projects.each do |project|
          expect(rendered).to have_link(project.client_company)
        end
      end

      it 'should have a link to edit' do
        expect(rendered).to have_link(I18n.t('views.project.actions.edit'))
      end

      it 'should have a link to add' do
        expect(rendered).to have_link(I18n.t('views.project.actions.add'))
      end

      it 'should not have a link to delete' do
        expect(rendered).not_to have_link(I18n.t('views.project.actions.delete'))
      end
    end
  end
end
