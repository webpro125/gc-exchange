require 'spec_helper'

describe 'phones/index.html.erb' do
  let(:phones) { FactoryGirl.build_stubbed_list(:phone, 3) }
  let(:phone_types) { FactoryGirl.build_stubbed_list(:phone_type, 3) }

  before do
    assign(:phones, phones)
    assign(:phone_types, phone_types)
    view.stub(:lookup_translation).and_return('hi')
    render
  end

  it 'should have number' do
    phones.each do |phone|
      expect(rendered).to have_text(phone.number)
    end
  end

  it 'should have phone_type' do
    expect(rendered).to have_text('hi')
  end

  it 'should have a link to show' do
    phones.each do |phone|
      expect(rendered).to have_link(phone.number)
    end
  end

  it 'should have a link to edit' do
    expect(rendered).to have_link(I18n.t('views.phone.actions.edit'))
  end

  it 'should have a link to add' do
    expect(rendered).to have_link(I18n.t('views.phone.actions.add'))
  end

  it 'should have a link to delete' do
    expect(rendered).to have_link(I18n.t('views.phone.actions.delete'))
  end
end
