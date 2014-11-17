require 'spec_helper'

describe UploadImageConsultantForm do
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

  let(:form) { UploadImageConsultantForm.new(consultant) }
  subject { form }

  it { should be_valid }

  describe 'consultant' do
    describe 'profile_image' do
      before do
        subject.profile_image = File.new(Rails.root + 'app/assets/images/default_profile.png')
      end

      it { should have_attached_file(:profile_image) }
      it { should validate_attachment_size(:profile_image).less_than(1.megabytes) }
      it { should_not validate_attachment_presence(:profile_image) }

      it do
        expect(subject).to(
          validate_attachment_content_type(:profile_image).allowing(image_types).rejecting(reject))
      end
    end
  end
end
