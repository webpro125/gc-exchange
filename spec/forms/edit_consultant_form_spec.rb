require 'spec_helper'

describe EditConsultantForm do


  let(:mime_types) do
    [
      'application/pdf'
    ]
  end

  let(:reject) do
    ['text/plain', 'text/xml']
  end

  let(:consultant) do
    Consultant.new(
      rate: 100,
      address: FactoryGirl.build(:address),
      military: FactoryGirl.build(:military),
      phones: FactoryGirl.build_list(:phone, 2),
      educations: FactoryGirl.build_list(:education, 2),
      abstract: Faker::Lorem.paragraph(4)
    )
  end

  let(:user) do
    User.new(
        first_name: 'Freddy',
        last_name: 'Kreuger',
        consultant: consultant
    )
  end

  let(:form) { EditConsultantForm.new(user) }

  subject { form.consultant }

  it_behaves_like 'qualifications'
  it_behaves_like 'other_information'

  # subject { form }


  it { should be_valid }

  describe 'consultant' do
    describe 'first_name' do
      it 'ensures length' do
        expect(form).to ensure_length_of(:first_name).is_at_least(2).is_at_most(64)
      end
      it 'presence' do
        expect(form).to validate_presence_of(:first_name)
      end
      it 'allow value' do
        expect(form).to allow_value('james', 'mary ann', 'Robert').for(:first_name)
      end
      it 'not allowed value' do
        expect(form).not_to allow_value('billy-jean 2', '1234567890', '!@#$%').for(:first_name)
      end
    end

    describe 'last_name' do
      it 'ensures length' do
        expect(form).to ensure_length_of(:last_name).is_at_least(2).is_at_most(64)
      end
      it 'presence' do
        expect(form).to validate_presence_of(:last_name)
      end
      it 'allow value' do
        expect(form).to allow_value('james', 'mary ann', 'billy-jean 2', '1234567890').for(:last_name)
      end

      it 'not allowed value' do
        expect(form).not_to allow_value('!@#$%').for(:last_name)
      end
    end

    describe 'abstract' do
      it 'ensures length' do
        expect(form.consultant).to ensure_length_of(:abstract).is_at_most(1500)
      end
      # it { should expect(subject.consultant.abstract).to ensure_length_of(:abstract).is_at_most(1500) }
    end
  end
end
