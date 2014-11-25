require 'spec_helper'

describe ConsultantIndexer do
  let(:consultant) { FactoryGirl.create(:consultant) }
  subject { ConsultantIndexer.new }

  before do
    allow(Consultant).to receive(:find) { consultant }
  end

  describe '#update' do
    it 'calls #update_document' do
      expect(consultant.__elasticsearch__).to receive(:index_document)
      subject.perform(:update, consultant.id)
    end
  end

  describe '#destroy' do
    it 'calls #delete_document' do
      expect(Consultant.__elasticsearch__.client).to receive(:delete)
      subject.perform(:destroy, consultant.id)
    end
  end

  describe '#anything_else' do
    it 'throws an error' do
      expect { subject.perform(:anything_else, consultant.id) }.to raise_error(ArgumentError)
    end
  end
end
