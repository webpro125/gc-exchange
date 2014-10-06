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
  it { should respond_to(:project_history_disciplines) }
  it { should respond_to(:disciplines) }

  describe 'client_company' do
    it 'should have minimum length' do
      subject.client_company = 'a' * 2
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.client_company = 'a' * 25
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.client_company = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only characters and numbers' do
      subject.client_company = 'John 123567'
      expect(subject).to be_valid

      subject.client_company = 'Mr. Edgardo Langworth'
      expect(subject).to be_valid
    end
  end

  describe 'client_poc_name' do
    it 'should have minimum length' do
      subject.client_poc_name = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.client_poc_name = 'a' * 64
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.client_poc_name = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only characters numbers and hyphens' do
      subject.client_poc_name = '123567'
      expect(subject).to be_valid

      subject.client_poc_name = 'james'
      expect(subject).to be_valid

      subject.client_poc_name = 'billy-jean 2'
      expect(subject).to be_valid

      subject.client_poc_name = '!@#$'
      expect(subject).not_to be_valid
    end
  end

  describe 'client_poc_email' do
    it 'should have minimum length' do
      subject.client_poc_email = 'a' * 2
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.client_poc_email = 'a' * 129
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.client_poc_email = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only valid email' do
      emails = %w[(test@test.com) (an-email@an-email.com) (3email@some.weird.email.org)]

      emails.each do |email|
        subject.client_poc_email = email
        expect(subject).to be_valid
      end

      emails = %w[(not.an.email) (not.an@email) (needavalid@12!@$#.com)]

      emails.each do |email|
        subject.client_poc_email = email
        expect(subject).not_to be_valid
      end
    end
  end

  describe 'start_date' do
    it 'should be present' do
      subject.start_date = nil
      expect(subject).not_to be_valid
    end

    it 'should not be greater than today' do
      subject.start_date = DateTime.now
      expect(subject).not_to be_valid
    end

    it 'should not be greater than end_date' do
      subject.start_date = 1.month.ago
      expect(subject).not_to be_valid
    end
  end

  describe 'end_date' do
    it 'is not required' do
      subject.end_date = nil
      expect(subject).to be_valid
    end

    it 'should not be greater than today' do
      subject.end_date = 3.months.from_now
      expect(subject).not_to be_valid
    end

    it 'should not be less than start_date' do
      subject.end_date = 3.years.ago
      expect(subject).not_to be_valid
    end
  end

  describe 'description' do
    it 'should have minimum length' do
      subject.description = 'a' * 2
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.description = 'a' * 1_501
      expect(subject).not_to be_valid
    end

    it 'should not be required' do
      subject.description = nil
      expect(subject).to be_valid
    end
  end

  describe 'association' do
    describe 'customer_name' do
      it 'should not be required' do
        expect(subject).not_to validate_presence_of :customer_name
      end
    end

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

    describe 'project_history_disciplines' do
      it 'should destroy them on delete' do
        subject.save!

        project_history_disciplines = subject.project_history_disciplines.map(&:id)
        expect(project_history_disciplines).not_to be_nil

        subject.destroy
        project_history_disciplines.each do |project_history_discipline|
          expect(ProjectHistoryDiscipline.find_by_id(project_history_discipline)).to be_nil
        end
      end
    end

    describe 'project_history_positions' do
      it 'should be required' do
        subject.project_history_positions.clear
        expect(subject).not_to be_valid
      end

      it 'should be invalid if not 100%' do
        subject.project_history_positions << FactoryGirl.build(:project_history_position)
        subject.project_history_positions.each do |project_history_position|
          project_history_position.percentage = 90
        end

        expect(subject).not_to be_valid
      end

      it 'should destroy them on delete' do
        subject.save!
        project_history_positions = subject.project_history_positions.map(&:id)
        expect(project_history_positions).not_to be_nil

        subject.destroy
        project_history_positions.each do |project_history_position|
          expect(ProjectHistoryPosition.find_by_id(project_history_position)).to be_nil
        end
      end

      it 'should have maximum size' do
        position_list = FactoryGirl.build_list(:project_history_position, 3)
        subject.project_history_positions << position_list
        expect(subject).not_to be_valid
      end

      it { should accept_nested_attributes_for(:project_history_positions).allow_destroy(true) }
    end

    describe 'project_type' do
      it 'should be present' do
        subject.project_type = nil
        expect(subject).to_not be_valid
      end

      it 'should not be destroyed on delete' do
        subject.save!
        project_type_id = subject.project_type_id

        subject.destroy
        expect(ProjectType.find_by_id(project_type_id)).to_not be_nil
      end
    end
  end
end
