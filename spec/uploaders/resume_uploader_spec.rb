require 'spec_helper'

describe ResumeUploader do
  subject { ResumeUploader.new(FactoryGirl.create(:consultant)) }
  before do
    ResumeUploader.enable_processing = true
    subject.store!(File.new(Rails.root + 'spec/files/a_pdf.pdf'))
  end

  after do
    ResumeUploader.enable_processing = false
    subject.remove!
  end
end
