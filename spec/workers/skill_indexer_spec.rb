require 'spec_helper'

describe SkillIndexer do
  let(:skill) { FactoryGirl.create(:skill) }
  subject { SkillIndexer.new }

  before do
    allow(Skill).to receive(:find) { skill }
  end

  describe '#update' do
    it 'calls #update_document' do
      expect(skill.__elasticsearch__).to receive(:index_document)
      subject.perform(:update, skill.id)
    end
  end

  describe '#destroy' do
    it 'calls #delete_document' do
      expect(Skill.__elasticsearch__.client).to receive(:delete)
      subject.perform(:destroy, skill.id)
    end
  end

  describe '#anything_else' do
    it 'throws an error' do
      expect { subject.perform(:anything_else, skill.id) }.to raise_error(ArgumentError)
    end
  end
end
