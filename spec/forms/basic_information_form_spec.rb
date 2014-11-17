require 'spec_helper'

describe BasicInformationForm do
  # it_behaves_like 'basic_information'

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
      abstract: Faker::Lorem.characters(150)
    )
  end

  subject { BasicInformationForm.new(consultant) }

  it { should be_valid }

  # describe 'consultant' do
  #   describe 'abstract' do
  #     it { should ensure_length_of(:abstract).is_at_least(2).is_at_most(1500) }
  #     it { should validate_presence_of(:abstract) }
  #   end
  # end
end
