require 'spec_helper'

describe ProjectHistory do
  it_behaves_like 'indexable', :client_poc_name=, 'Alvinseraph'

  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }
  let!(:customer_name) { FactoryGirl.create(:customer_name) }
  let!(:project_history_position_list) do
    FactoryGirl.build_list(:project_history_position, 2, percentage: 50)
  end

  subject do
    ProjectHistory.new(consultant: consultant,
                       customer_name: customer_name,
                       client_company: 'Client company',
                       client_poc_name: 'POC Name',
                       client_poc_email: 'poc@email.com',
                       start_date: 2.years.ago,
                       end_date: 1.year.ago,
                       project_type: FactoryGirl.create(:project_type),
                       project_history_positions: project_history_position_list,
                       description: 'A short little quip of a description')
  end

  it { should be_valid }

  it { should have_one(:phone).dependent(:destroy) }

  describe 'association' do
    describe 'consultant' do
      before do
        subject.save!
      end

      it 'should not be destroyed on delete' do
        consultant_id = subject.consultant_id

        subject.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'project_history_positions' do
      it 'should destroy them on delete' do
        subject.save!
        project_history_positions = subject.project_history_positions.map(&:id)
        expect(project_history_positions).not_to be_nil

        subject.destroy
        project_history_positions.each do |project_history_position|
          expect(ProjectHistoryPosition.find_by_id(project_history_position)).to be_nil
        end
      end
    end

    describe 'project_type' do
      it 'should not be destroyed on delete' do
        subject.save!
        project_type_id = subject.project_type_id

        subject.destroy
        expect(ProjectType.find_by_id(project_type_id)).to_not be_nil
      end
    end
  end
end
