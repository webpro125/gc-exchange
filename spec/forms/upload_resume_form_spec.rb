require 'spec_helper'

describe UploadResumeForm do

  it_behaves_like 'upload_resume'

  let!(:user) { FactoryGirl.create(:user) }
  let(:consultant) do
    Consultant.new(
      rate: 100,
      skills: FactoryGirl.build_list(:skill, 3),
      military: FactoryGirl.build(:military),
      address: FactoryGirl.build(:address),
      phones: FactoryGirl.build_list(:phone, 2),
      abstract: Faker::Lorem.characters(150),
      resume: File.new(Rails.root + 'spec/files/a_pdf.pdf'),
      user: user
    )
  end

  subject { UploadResumeForm.new(consultant) }

  it { should be_valid }
end
