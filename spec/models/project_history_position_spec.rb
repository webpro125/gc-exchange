require 'spec_helper'

describe ProjectHistoryPosition do
  let(:project_history) { FactoryGirl.create(:project_history) }
  let(:position) { FactoryGirl.create(:position) }
  before do
    @project_history_position = ProjectHistoryPosition.new(project_history: project_history,
                                                           position: position,
                                                           percentage: 100)
  end

  subject { @project_history_position }

  it { should be_valid }

  it { should respond_to(:project_history) }
  it { should respond_to(:position) }
  it { should respond_to(:percentage) }

  describe 'associations' do
    describe 'position' do
      it { should validate_presence_of :position }
    end

    describe 'project_history' do
      it { should validate_presence_of :project_history }
      it { should validate_uniqueness_of(:project_history).scoped_to(:position_id) }
    end
  end
end
