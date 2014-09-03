require 'spec_helper'

describe "phones/index.html.erb" do
  before do
    @phones = [mock_model(Phone, phone_type: mock_model(PhoneType)),
              mock_model(Phone, phone_type: mock_model(PhoneType))]
    assign(:phones, @phones)
    assign(:phone_types, [{id: 1, code: 'CELL'}])
    view.stub(:lookup_translation).and_return('hi')
    render
  end

  it 'should have number' do
    @phones.each do |phone|
      expect(rendered).to have_text(phone.number)
    end
  end

  it 'should have phone_type' do
    expect(rendered).to have_text('hi')
  end

  it 'should have a link to show' do
    @phones.each do |phone|
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
