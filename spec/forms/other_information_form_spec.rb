require 'spec_helper'

describe OtherInformationForm do
  it_behaves_like 'other_information'

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
      entity: FactoryGirl.build(:entity),
      phones: FactoryGirl.build_list(:phone, 2)
    )
  end

  subject { OtherInformationForm.new(consultant) }

  it { should be_valid }
end
