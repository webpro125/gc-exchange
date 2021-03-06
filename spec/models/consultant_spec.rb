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
      first_name:            'Freddy',
      last_name:             'Kreuger',
      email:                 'freddy.kreuger@globalconsultantexchange.com',
      password:              'password',
      password_confirmation: 'password',
      abstract:              'Testing the abstract'
    )
  end

  it { should be_valid }
  it { should respond_to(:background) }
  it { should respond_to(:approved_status) }
  it { should respond_to(:approved?) }
  it { should respond_to(:rejected?) }
  it { should respond_to(:in_progress?) }
  it { should respond_to(:pending_approval?) }

  it { expect(subject).to have_many(:projects).dependent(:destroy) }
  it { expect(subject).to have_many(:consultant_certifications).dependent(:destroy) }
  it { expect(subject).to have_many(:educations).dependent(:destroy) }
  it { expect(subject).to have_many(:certifications) }
  it { expect(subject).to have_many(:consultant_skills).dependent(:destroy) }
  it { expect(subject).to have_many(:skills) }
  it { expect(subject).to have_many(:phones).dependent(:destroy) }
  it { expect(subject).to have_many(:shared_contacts).dependent(:destroy) }

  it { expect(subject).to have_one(:address).dependent(:destroy) }
  it { expect(subject).to have_one(:entity).dependent(:destroy) }
  it { expect(subject).to have_one(:background).dependent(:destroy) }

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
