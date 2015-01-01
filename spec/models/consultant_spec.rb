require 'spec_helper'

describe Consultant do
  let(:mime_types) do
    [
      'application/pdf'
    ]
  end

  let(:image_types) do
    [
      'image/jpg',
      'image/png',
      'image/gif'
    ]
  end

  let(:reject) do
    ['text/plain', 'text/xml', 'image/tiff']
  end

  subject do
    Consultant.new(
      first_name: 'Freddy',
      last_name: 'Kreuger',
      email: 'freddy.kreuger@globalconsultantexchange.com',
      password: 'password',
      password_confirmation: 'password',
      abstract: 'Testing the abstract'
    )
  end

  it { should be_valid }
  it { should respond_to(:background) }
  it { should respond_to(:phones) }
  it { should respond_to(:educations) }
  it { should respond_to(:approved_status) }
  it { should respond_to(:approved?) }
  it { should respond_to(:rejected?) }
  it { should respond_to(:in_progress?) }
  it { should respond_to(:pending_approval?) }

  describe 'resume' do
    before do
      subject.resume = File.new(Rails.root + 'spec/files/a_pdf.pdf')
    end

    it { should respond_to(:resume) }
  end

  describe 'profile_image' do
    before do
      subject.profile_image = File.new(Rails.root + 'app/assets/images/default_profile.png')
    end

    it { should respond_to(:profile_image) }
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

    describe 'background' do
      before do
        subject.save!
        FactoryGirl.create(:background, consultant: subject)
      end

      it 'should be destroyed on delete' do
        background = subject.background.id
        expect(background).not_to be_nil

        subject.destroy
        expect(Background.find_by_id(background)).to be_nil
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

    describe 'educations' do
      before do
        subject.educations << FactoryGirl.create(:education)
        subject.save!
      end

      it 'should destroy them on delete' do
        educations = subject.educations.map(&:id)
        expect(educations).not_to be_nil

        subject.destroy
        educations.each do |education|
          expect(Education.find_by_id(education)).to be_nil
        end
      end

      it 'should not allow more than 3' do
        subject.educations << FactoryGirl.build_list(:education, 4)
        expect(subject).not_to be_valid
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
        subject.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::APPROVED[:code])
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
          expect(subject.__elasticsearch__).to receive(:delete_document)
          subject.destroy!
        end
      end
    end

    describe 'rejected' do
      before do
        subject.save!
      end

      describe '#update' do
        before do
          ConsultantIndexer.jobs.clear
          subject.approved_status = ApprovedStatus.find_by_code(ApprovedStatus::REJECTED[:code])
        end

        it 'should start a job' do
          expect(ConsultantIndexer).to receive(:perform_async).with(:destroy,
                                                                    subject.id)
          subject.save!
        end

        it 'should add a job to queue' do
          subject.save!
          expect(ConsultantIndexer.jobs.size).to eq 1
        end
      end

      describe '#destroy' do
        before do
          subject.save!
        end

        it 'should delete document' do
          expect(subject.__elasticsearch__).to receive(:delete_document)
          subject.destroy!
        end
      end
    end
  end
end
