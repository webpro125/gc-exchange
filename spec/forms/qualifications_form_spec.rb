require 'spec_helper'

describe QualificationsForm do
  it_behaves_like 'qualifications'

  let(:user) { FactoryGirl.create(:user)}

  let(:consultant) do
    Consultant.new(
      rate: 100,
      skills: FactoryGirl.build_list(:skill, 3),
      certifications: FactoryGirl.build_list(:certification, 3),
      educations: FactoryGirl.build_list(:education, 2),
      user: user
    )
  end

  let(:form) { QualificationsForm.new(consultant) }
  subject { form }

  it { should be_valid }
end
