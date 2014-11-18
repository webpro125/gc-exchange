require 'spec_helper'

describe BasicInformationForm do
  it_behaves_like 'basic_information'
  it_behaves_like 'upload_image'
  it_behaves_like 'upload_resume'

  let(:consultant) do
    Consultant.new(
      first_name: 'Freddy',
      last_name: 'Kreuger',
      rate: 100,
      skills: FactoryGirl.build_list(:skill, 3),
      certifications: FactoryGirl.build_list(:certification, 3),
      educations: FactoryGirl.build_list(:education, 2),
      military: FactoryGirl.build(:military),
      address: FactoryGirl.build(:address),
      phones: FactoryGirl.build_list(:phone, 2),
      abstract: Faker::Lorem.characters(150),
      profile_image: File.new(Rails.root + 'spec/fixtures/default_profile.png'),
      resume: File.new(Rails.root + 'spec/files/a_pdf.pdf')
    )
  end

  subject { BasicInformationForm.new(consultant) }

  it { should be_valid }

  it { should_not validate_presence_of(:profile_image) }
end
