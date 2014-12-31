require 'spec_helper'

describe ProfileImageUploader do
  subject { ProfileImageUploader.new(FactoryGirl.create(:consultant)) }
  before do
    ProfileImageUploader.enable_processing = true
    subject.store!(File.new(Rails.root + 'app/assets/images/default_profile.png'))
  end

  after do
    ProfileImageUploader.enable_processing = false
    subject.remove!
  end

  context 'the original version' do
    it 'should be 400x400' do
      subject.should have_dimensions(400, 400)
    end
  end

  context 'the thumb version' do
    it 'should be 80x80' do
      subject.thumb.should have_dimensions(80, 80)
    end
  end

  context 'the medium' do
    it 'should be 200x200' do
      subject.medium.should have_dimensions(200, 200)
    end
  end
end
