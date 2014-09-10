require 'spec_helper'

describe 'phones/show.html.erb' do
  before do
    @phone = mock_model(Phone, phone_type: mock_model(PhoneType))
    assign(:phone, @phone)
    assign(:phone_types, [{ id: 1, code: 'CELL' }])
    view.stub(:lookup_translation).and_return('hi')
    render
  end

  it 'should have number' do
    expect(rendered).to have_text(@phone.number)
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
