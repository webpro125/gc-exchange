require 'spec_helper'

describe Message do
  subject do
    Message.new(
    subject: 'Test Subject',
    message: 'This is a test message'
  )
  end

  it { should be_valid }

  describe 'subject' do
    it { should validate_presence_of(:subject) }
  end

  describe 'message' do
    it { should validate_presence_of(:message) }
  end
end
