require 'spec_helper'

describe UploadImageForm do
  it_behaves_like 'upload_image'

  let!(:user) { FactoryGirl.create(:user) }
  let(:image_types) do
    [
      'image/jpg',
      'image/png',
      'image/gif'
    ]
  end

  let(:reject) do
    ['image/tiff']
  end

  let(:consultant) do
    Consultant.new(
      rate: 100,
      address: FactoryGirl.build(:address),
      military: FactoryGirl.build(:military),
      phones: FactoryGirl.build_list(:phone, 2),
      profile_image: File.new(Rails.root + 'spec/fixtures/default_profile.png'),
      user: user
    )
  end

  subject { UploadImageForm.new(consultant) }

  it { should be_valid }

  it { should validate_presence_of(:profile_image) }
end
