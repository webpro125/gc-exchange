require 'spec_helper'

describe UploadImageForm do
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
      first_name: 'Freddy',
      last_name: 'Kreuger',
      rate: 100,
      address: FactoryGirl.build(:address),
      military: FactoryGirl.build(:military),
      phones: FactoryGirl.build_list(:phone, 2)
    )
  end

  subject { UploadImageForm.new(consultant) }

  it { should be_valid }

  describe 'consultant' do
    describe 'profile_image' do
      before do
        subject.profile_image = File.new(Rails.root + 'app/assets/images/default_profile.png')
      end

      it { should respond_to(:profile_image) }
    end
  end
end
