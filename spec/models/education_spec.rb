require 'spec_helper'

describe Education do
  subject do
    Education.new(
      consultant: FactoryGirl.build(:consultant),
      degree: FactoryGirl.create(:degree),
      school: 'Harvard',
      field_of_study: 'Computer Science'
    )
  end

  it { should be_valid }

  describe 'school' do
    it { should validate_presence_of(:school) }
    it { should ensure_length_of(:school).is_at_least(2).is_at_most(256) }
  end

  describe 'field_of_study' do
    it { should validate_presence_of(:field_of_study) }
    it { should ensure_length_of(:field_of_study).is_at_least(2).is_at_most(256) }
  end

  describe 'associations' do
    before do
      subject.save!
    end

    describe 'degree' do
      it 'should not be destroyed' do
        id = subject.degree.id
        subject.destroy
        expect(Degree.find_by_id(id)).not_to be_nil
      end

      it { should validate_presence_of(:degree) }
    end

    describe 'consultant' do
      it 'should not be destroyed' do
        id = subject.consultant.id
        subject.destroy
        expect(Consultant.find_by_id(id)).not_to be_nil
      end

      it { should validate_presence_of(:consultant) }
    end
  end
end
