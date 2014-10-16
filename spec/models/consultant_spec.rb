require 'spec_helper'

describe Consultant do
  let(:consultant) do
    Consultant.new(
      first_name: 'Freddy',
      last_name: 'Kreuger',
      email: 'freddy.kreuger@globalconsultantexchange.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  let(:mime_types) do
    [
      'application/msword',
      'application/vnd.ms-word',
      'applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document',
      'application/pdf'
    ]
  end

  let(:reject) do
    ['text/plain', 'text/xml']
  end

  subject { consultant }

  it { should be_valid }
  it { should respond_to(:phones) }
  it { should respond_to(:approved_status) }
  it { should respond_to(:approved?) }

  describe 'first_name' do
    it 'should have minimum length' do
      subject.first_name = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.first_name = 'a' * 25
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.first_name = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only characters numbers and hyphens' do
      subject.first_name = 'james'
      expect(subject).to be_valid

      subject.first_name = 'billy-jean 2'
      expect(subject).not_to be_valid

      subject.first_name = '123567'
      expect(subject).not_to be_valid

      subject.first_name = '!@#$'
      expect(subject).not_to be_valid
    end
  end

  describe 'last_name' do
    it 'should have minimum length' do
      subject.last_name = 'a' * 1
      expect(subject).not_to be_valid
    end

    it 'should have maximum length' do
      subject.last_name = 'a' * 25
      expect(subject).not_to be_valid
    end

    it 'should be present' do
      subject.last_name = nil
      expect(subject).not_to be_valid
    end

    it 'should allow only characters and numbers' do
      subject.last_name = 'John 123567'
      expect(subject).to be_valid

      subject.last_name = '!@#$'
      expect(subject).not_to be_valid
    end
  end

  describe 'rate' do
    it { should validate_numericality_of(:rate). is_greater_than(0).allow_nil }
  end

  describe 'resume' do
    before do
      subject.resume = File.new(Rails.root + 'spec/files/a_pdf.pdf')
    end

    it { should have_attached_file(:resume) }
    it { should validate_attachment_size(:resume).less_than(10.megabytes) }
    it { should validate_attachment_content_type(:resume).allowing(mime_types).rejecting(reject) }

    it { should_not validate_attachment_presence(:resume) }
  end

  describe 'full_name' do
    it 'should container first_name' do
      expect(subject.full_name).to include(subject.first_name)
    end

    it 'should container last_name' do
      expect(subject.full_name).to include(subject.last_name)
    end
  end

  describe 'association' do
    describe 'address' do
      before do
        subject.save!
        FactoryGirl.create(:address, consultant: subject)
      end

      it 'should be destroyed on delete' do
        address = subject.address.id
        expect(address).not_to be_nil

        subject.destroy
        expect(Address.find_by_id(address)).to be_nil
      end
    end

    describe 'phones' do
      before do
        subject.phones << FactoryGirl.create(:phone)
        subject.save!
      end

      it 'should destroy them on delete' do
        phones = subject.phones.map(&:id)
        expect(phones).not_to be_nil

        subject.destroy
        phones.each do |phone|
          expect(Phone.find_by_id(phone)).to be_nil
        end
      end

      it 'should not allow more than 3' do
        subject.phones << FactoryGirl.build_list(:phone, 3)
        expect(subject).not_to be_valid
      end
    end

    describe 'skills' do
      before do
        subject.skills << FactoryGirl.create(:skill)
        subject.save!
      end

      it 'should not destroy them on delete' do
        skills = subject.skills.map(&:id)
        expect(skills).not_to be_nil

        subject.destroy
        skills.each do |skill|
          expect(Skill.find_by_id(skill)).not_to be_nil
        end
      end
    end

    describe 'consultant_skills' do
      before do
        subject.skills << FactoryGirl.create(:skill)
        subject.save!
      end

      it 'should destroy them on delete' do
        consultant_skills = subject.consultant_skills.map(&:id)

        subject.destroy
        consultant_skills.each do |skill|
          expect(ConsultantSkill.find_by_id(skill)).to be_nil
        end
      end

      it 'should not allow more than 20' do
        subject.skills << FactoryGirl.build_list(:skill, 21)
        expect(subject).not_to be_valid
      end
    end

    describe 'certifications' do
      before do
        subject.certifications << FactoryGirl.create(:certification)
        subject.save!
      end

      it 'should not destroy them on delete' do
        certifications = subject.certifications.map(&:id)
        expect(certifications).not_to be_nil

        subject.destroy
        certifications.each do |certification|
          expect(Certification.find_by_id(certification)).not_to be_nil
        end
      end

      it 'should not allow more than 10' do
        subject.certifications << FactoryGirl.build_list(:certification, 11)
        expect(subject).not_to be_valid
      end
    end

    describe 'consultant_certifications' do
      before do
        subject.certifications << FactoryGirl.create(:certification)
        subject.save!
      end

      it 'should destroy them on delete' do
        consultant_certifications = subject.consultant_certifications.map(&:id)

        subject.destroy
        consultant_certifications.each do |consultant_certification|
          expect(ConsultantCertification.find_by_id(consultant_certification)).to be_nil
        end
      end
    end

    describe 'approved_status' do
      it 'should not destroy them on delete' do
        subject.save!
        approved_status = subject.approved_status.id

        subject.destroy
        expect(ApprovedStatus.find(approved_status)).not_to be_nil
      end
    end
  end

  describe 'indexing' do
    describe 'approved' do
      before do
        subject.save!
        subject.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::APPROVED)
      end

      describe '#update' do
        before do
          ConsultantIndexer.jobs.clear
        end

        it 'should start a job' do
          expect(ConsultantIndexer).to receive(:perform_async).with(:update, subject.id)
          subject.save!
        end

        it 'should add a job to queue' do
          subject.save!
          expect(ConsultantIndexer.jobs.size).to eq 1
        end
      end

      describe '#destroy' do
        it 'should delete document' do
          expect(subject).to receive(:delete_document)
          subject.destroy!
        end
      end
    end

    describe 'not approved' do
      before do
        subject.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::REJECTED)
        subject.save!
      end

      describe '#update' do
        before do
          subject.save!
          ConsultantIndexer.jobs.clear
        end

        it 'should not start a job' do
          expect(ConsultantIndexer).not_to receive(:perform_async).with(:update,
                                                                        subject.id)
          subject.save!
        end

        it 'should not add a job to queue' do
          subject.save!
          expect(ConsultantIndexer.jobs.size).to eq 0
        end
      end

      describe '#destroy' do
        before do
          subject.save!
        end

        it 'should delete document' do
          expect(subject).to receive(:delete_document)
          subject.destroy!
        end
      end
    end
  end
end
