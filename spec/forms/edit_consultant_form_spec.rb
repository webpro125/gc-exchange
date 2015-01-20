require 'spec_helper'

describe EditConsultantForm do
  it_behaves_like 'qualifications'
  it_behaves_like 'other_information'

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
      first_name: 'Freddy',
      last_name: 'Kreuger',
      rate: 100,
      address: FactoryGirl.build(:address),
      military: FactoryGirl.build(:military),
      phones: FactoryGirl.build_list(:phone, 2),
      educations: FactoryGirl.build_list(:education, 2)
    )
  end
  let(:form) { EditConsultantForm.new(consultant) }
  subject { form }

  it { should be_valid }

  describe 'consultant' do
    describe 'first_name' do
      it { should ensure_length_of(:first_name).is_at_least(2).is_at_most(64) }
      it { should validate_presence_of(:first_name) }
      it { should allow_value('james', 'mary ann', 'Robert').for(:first_name) }

      it { should_not allow_value('billy-jean 2', '1234567890', '!@#$%').for(:first_name) }
    end

    describe 'last_name' do
      it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(64) }
      it { should validate_presence_of(:last_name) }
      it { should allow_value('james', 'mary ann', 'billy-jean 2', '1234567890').for(:last_name) }

      it { should_not allow_value('!@#$%').for(:last_name) }
    end

    describe 'abstract' do
      it { should ensure_length_of(:abstract).is_at_most(1500) }
    end
  end
end
