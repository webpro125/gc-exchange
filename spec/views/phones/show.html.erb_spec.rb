require 'spec_helper'

describe 'phones/show.html.erb' do
  let(:policy) { allow(view).to receive(:policy) }
  let(:phone) { FactoryGirl.build_stubbed(:phone) }

  before do
    assign(:phone, phone)
    assign(:phone_types, FactoryGirl.build_stubbed_list(:phone, 3))
    view.stub(:lookup_translation).and_return('hi')
  end

  describe 'with access' do
    before do
      policy.and_return double(edit?: true, destroy?: true)
      render
    end

    it 'should have number' do
      expect(rendered).to have_text(phone.number)
    end

    it 'should have phone_type' do
      expect(rendered).to have_text('hi')
    end

    it 'should have a link to edit' do
      expect(rendered).to have_link(I18n.t('views.phone.actions.edit'))
    end

    it 'should have a link to delete' do
      expect(rendered).to have_link(I18n.t('views.phone.actions.delete'))
    end
  end

  describe 'without access to' do
    describe 'edit' do
      before do
        policy.and_return double(edit?: false, destroy?: true)
        render
      end

      it 'should have number' do
        expect(rendered).to have_text(phone.number)
      end

      it 'should have phone_type' do
        expect(rendered).to have_text('hi')
      end

      it 'should not have a link to edit' do
        expect(rendered).not_to have_link(I18n.t('views.phone.actions.edit'))
      end

      it 'should have a link to delete' do
        expect(rendered).to have_link(I18n.t('views.phone.actions.delete'))
      end
    end

    describe 'destroy' do
      before do
        policy.and_return double(edit?: true, destroy?: false)
        render
      end

      it 'should have number' do
        expect(rendered).to have_text(phone.number)
      end

      it 'should have phone_type' do
        expect(rendered).to have_text('hi')
      end

      it 'should have a link to edit' do
        expect(rendered).to have_link(I18n.t('views.phone.actions.edit'))
      end

      it 'should not have a link to delete' do
        expect(rendered).not_to have_link(I18n.t('views.phone.actions.delete'))
      end
    end
  end
end
