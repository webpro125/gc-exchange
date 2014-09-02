require 'spec_helper'

describe ProjectHistoryDiscipline do
  let(:project_history) { FactoryGirl.create(:project_history) }
  let(:discipline) { FactoryGirl.create(:discipline) }
  before do
    @project_history_discipline = ProjectHistoryDiscipline.new(project_history: project_history,
                                                               discipline: discipline)
  end

  subject { @project_history_discipline }

  it { should be_valid }

  describe 'association' do
    describe 'project_history' do
      it 'should be present' do
        @project_history_discipline.project_history = nil
        expect(@project_history_discipline).not_to be_valid
      end

      it 'should not be destroyed on delete' do
        @project_history_discipline.save!
        project_history_id = @project_history_discipline.project_history_id

        @project_history_discipline.destroy
        expect(ProjectHistory.find_by_id(project_history_id)).not_to be_nil
      end
    end

    describe 'discipline' do
      it 'should be present' do
        @project_history_discipline.discipline = nil
        expect(@project_history_discipline).not_to be_valid
      end

      it 'should not be destroyed on delete' do
        @project_history_discipline.save!
        discipline_id = @project_history_discipline.discipline_id

        @project_history_discipline.destroy
        expect(Discipline.find_by_id(discipline_id)).not_to be_nil
      end
    end
  end
end
