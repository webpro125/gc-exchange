require 'spec_helper'

describe ProjectHistory do
  let(:consultant) { FactoryGirl.create(:confirmed_consultant) }
  let(:customer_name) { FactoryGirl.create(:customer_name) }
  before do
    @project_history = ProjectHistory.new(consultant: consultant,
                                          customer_name: customer_name,
                                          client_company: 'Client company',
                                          client_poc_name: 'POC Name',
                                          client_poc_email: 'poc@email.com',
                                          start_date: 2.years.ago,
                                          end_date: 1.year.ago,
                                          position: FactoryGirl.create(:position),
                                          description: 'A short little quip of a description')
  end

  subject { @project_history }

  it { should be_valid }
  it { should respond_to(:project_history_disciplines) }
  it { should respond_to(:disciplines) }

  describe 'client_company' do
    it 'should have minimum length' do
      @project_history.client_company = 'a' * 2
      expect(@project_history).not_to be_valid
    end

    it 'should have maximum length' do
      @project_history.client_company = 'a' * 25
      expect(@project_history).not_to be_valid
    end

    it 'should be present' do
      @project_history.client_company = nil
      expect(@project_history).not_to be_valid
    end

    it 'should allow only characters and numbers' do
      @project_history.client_company = 'John 123567'
      expect(@project_history).to be_valid

      @project_history.client_company = 'Mr. Edgardo Langworth'
      expect(@project_history).to be_valid
    end
  end

  describe 'client_poc_name' do
    it 'should have minimum length' do
      @project_history.client_poc_name = 'a' * 2
      expect(@project_history).not_to be_valid
    end

    it 'should have maximum length' do
      @project_history.client_poc_name = 'a' * 64
      expect(@project_history).not_to be_valid
    end

    it 'should be present' do
      @project_history.client_poc_name = nil
      expect(@project_history).not_to be_valid
    end

    it 'should allow only characters numbers and hyphens' do
      @project_history.client_poc_name = '123567'
      expect(@project_history).to be_valid

      @project_history.client_poc_name = 'james'
      expect(@project_history).to be_valid

      @project_history.client_poc_name = 'billy-jean 2'
      expect(@project_history).to be_valid

      @project_history.client_poc_name = '!@#$'
      expect(@project_history).not_to be_valid
    end
  end

  describe 'client_poc_email' do
    it 'should have minimum length' do
      @project_history.client_poc_email = 'a' * 2
      expect(@project_history).not_to be_valid
    end

    it 'should have maximum length' do
      @project_history.client_poc_email = 'a' * 129
      expect(@project_history).not_to be_valid
    end

    it 'should be present' do
      @project_history.client_poc_email = nil
      expect(@project_history).not_to be_valid
    end

    it 'should allow only valid email' do
      emails = %w[(test@test.com) (an-email@an-email.com) (3email@some.weird.email.org)]

      emails.each do |email|
        @project_history.client_poc_email = email
        expect(@project_history).to be_valid
      end

      emails = %w[(not.an.email) (not.an@email) (needavalid@12!@$#.com)]

      emails.each do |email|
        @project_history.client_poc_email = email
        expect(@project_history).not_to be_valid
      end
    end
  end

  describe 'start_date' do
    it 'should be present' do
      @project_history.start_date = nil
      expect(@project_history).not_to be_valid
    end

    it 'should not be greater than today' do
      @project_history.start_date = DateTime.now
      expect(@project_history).not_to be_valid
    end

    it 'should not be greater than end_date' do
      @project_history.start_date = 1.month.ago
      expect(@project_history).not_to be_valid
    end
  end

  describe 'end_date' do
    it 'is not required' do
      @project_history.end_date = nil
      expect(@project_history).to be_valid
    end

    it 'should not be greater than today' do
      @project_history.end_date = 3.months.from_now
      expect(@project_history).not_to be_valid
    end

    it 'should not be less than start_date' do
      @project_history.end_date = 3.years.ago
      expect(@project_history).not_to be_valid
    end
  end

  describe 'description' do
    it 'should have minimum length' do
      @project_history.description = 'a' * 2
      expect(@project_history).not_to be_valid
    end

    it 'should have maximum length' do
      @project_history.description = 'a' * 10_001
      expect(@project_history).not_to be_valid
    end

    it 'should be required' do
      @project_history.description = nil
      expect(@project_history).to be_valid
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
        @project_history.save!
      end

      it 'should not be destroyed on delete' do
        consultant_id = @project_history.consultant_id

        @project_history.destroy
        expect(Consultant.find_by_id(consultant_id)).not_to be_nil
      end
    end

    describe 'position' do
      it 'should be present' do
        @project_history.position = nil
        expect(@project_history).to_not be_valid
      end

      it 'should not be destroyed on delete' do
        @project_history.save!
        position_id = @project_history.position_id

        @project_history.destroy
        expect(Position.find_by_id(position_id)).to_not be_nil
      end
    end

    describe 'project_history_disciplines' do
      before do
        @project_history.save!
        FactoryGirl.create_list(:project_history_discipline, 3, project_history: @project_history)
      end

      it 'should destroy them on delete' do
        project_history_disciplines = @project_history.project_history_disciplines.map(&:id)
        expect(project_history_disciplines).not_to be_nil

        @project_history.destroy
        project_history_disciplines.each do |project_history_discipline|
          expect(ProjectHistoryDiscipline.find_by_id(project_history_discipline)).to be_nil
        end
      end
    end
  end
end
