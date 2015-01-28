require 'spec_helper'

describe ProjectHistoryForm do
  let!(:consultant) { FactoryGirl.create(:confirmed_consultant, :approved) }

  subject do
    ProjectHistoryForm.new(
      ProjectHistory.new(consultant:       consultant,
                         customer_name:    FactoryGirl.create(:customer_name),
                         client_company:   'Client company',
                         client_poc_name:  'POC Name',
                         client_poc_email: 'poc@email.com',
                         start_date:       2.years.ago,
                         end_date:         1.year.ago,
                         project_type:     FactoryGirl.create(:project_type),
                         positions:        FactoryGirl.create_list(:position, 2),
                         description:      'A short little quip of a description',
                         phone:            FactoryGirl.build(:phone)))
  end

  describe 'client_company' do
    it { should ensure_length_of(:client_company).is_at_least(3).is_at_most(512) }
    it { should validate_presence_of(:client_company) }

    it 'should allow only characters and numbers' do
      subject.client_company = 'John 123567'
      expect(subject).to be_valid

      subject.client_company = 'Mr. Edgardo Langworth'
      expect(subject).to be_valid
    end
  end

  describe 'client_poc_name' do
    it { should ensure_length_of(:client_poc_name).is_at_least(2).is_at_most(256) }
    it { should validate_presence_of(:client_poc_name) }

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
    it { should ensure_length_of(:client_poc_email).is_at_least(3).is_at_most(128) }
    it { should validate_presence_of(:client_poc_email) }

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
    it { should validate_presence_of(:start_date) }

    it 'should not be greater than today' do
      subject.start_date = 5.minutes.from_now
      expect(subject).not_to be_valid
    end

    it 'should not be greater than end_date' do
      subject.start_date = 1.month.ago
      expect(subject).not_to be_valid
    end
  end

  describe 'end_date' do
    it { should_not validate_presence_of(:end_date) }

    it 'should not be greater than today' do
      subject.end_date = 3.months.from_now
      expect(subject).not_to be_valid
    end

    it 'should not be less than start_date' do
      subject.end_date = 3.years.ago
      expect(subject).not_to be_valid
    end

    it 'can be equal to start date' do
      subject.end_date = subject.start_date
      expect(subject).to be_valid
    end
  end

  describe 'description' do
    it { should ensure_length_of(:description).is_at_least(3).is_at_most(1_500) }
    it { should_not validate_presence_of(:description) }
  end

  describe 'position_ids' do
    it { should ensure_length_of(:position_ids).is_at_least(1).is_at_most(3) }
  end

  describe 'project_type_id' do
    it { should validate_presence_of(:project_type_id) }
  end
end
