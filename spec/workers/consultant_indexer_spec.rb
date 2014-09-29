require 'spec_helper'

describe ConsultantIndexer do
  let(:consultant) { FactoryGirl.create(:consultant) }
  subject { ConsultantIndexer.new }

  before do
    allow(Consultant).to receive(:find) { consultant }
  end

  describe '#update' do
    it 'calls #update_document' do
      expect(consultant).to receive(:index_document)
      subject.perform(:update, consultant.id)
    end
  end

  describe '#destroy' do
    it 'calls #delete_document' do
      expect(consultant).to receive(:delete_document)
      subject.perform(:destroy, consultant.id)
    end
  end

  describe '#anything_else' do
    it 'throws an error' do
      expect { subject.perform(:anything_else, consultant.id) }.to raise_error(ArgumentError)
    end
  end
end
