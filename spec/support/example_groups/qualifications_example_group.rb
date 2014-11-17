shared_examples 'qualifications' do
  describe 'skills_list' do
    it { should respond_to :skills_list }
  end

  describe 'certification_ids' do
    it { should respond_to :certification_ids }
  end

  describe 'educations' do
    it { should respond_to :educations }

    describe 'degree_id' do
      it do
        expect(subject.educations.first).to validate_presence_of(:degree_id)
      end
    end

    describe 'field_of_study' do
      it do
        expect(subject.educations.first).to validate_presence_of(:field_of_study)
      end

      it do
        expect(subject.educations.first).to(
          ensure_length_of(:field_of_study).is_at_least(2).is_at_most(256))
      end
    end

    describe 'school' do
      it do
        expect(subject.educations.first).to validate_presence_of(:school)
      end

      it do
        expect(subject.educations.first).to(
          ensure_length_of(:school).is_at_least(2).is_at_most(256))
      end
    end
  end
end
